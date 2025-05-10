module XmlLaborabrechnungsdaten
  class MwstGruppe
    include MemberContainer

    # @!attribute zwischensumme_netto
    #   @return [String] Net subtotal amount
    member :zwischensumme_netto, type: String

    # @!attribute mehrwertsteuersatz
    #   @return [String] VAT rate
    member :mehrwertsteuersatz, type: String

    # @!attribute mehrwertsteuerbetrag
    #   @return [String] VAT amount
    member :mehrwertsteuerbetrag, type: String

    # @!attribute positionen
    #   @return [Array<Position>] List of positions in this VAT group
    member :positionen, type: Array, default: []

    # Adds a position to the VAT group
    # @param position [Position] Position to add
    # @return [Array<Position>] Updated list of positions
    def add_position(position)
      positionen << position
      positionen
    end

    # Generates XML representation of the VAT group
    # @param xml [Builder::XmlMarkup] XML builder instance
    # @return [void]
    def to_xml(xml)
      attributes = {
        Zwischensumme_netto: zwischensumme_netto,
        Mehrwertsteuersatz: mehrwertsteuersatz,
        Mehrwertsteuerbetrag: mehrwertsteuerbetrag
      }.compact # Removes nil values

      xml.tag!(:"MWST-Gruppe", attributes) do
        # Add all positions as child elements
        positionen.each do |position|
          position.to_xml(xml)
        end
      end
    end
  end
end
