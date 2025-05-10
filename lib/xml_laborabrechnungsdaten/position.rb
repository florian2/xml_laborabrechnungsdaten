module XmlLaborabrechnungsdaten
  class Position
    include MemberContainer

    # @!attribute art
    #   @return [String] Type of the position (e.g., "BEL")
    member :art, type: String

    # @!attribute nummer
    #   @return [String] Number/identifier of the position
    member :nummer, type: String

    # @!attribute beschreibung
    #   @return [String] Description of the position
    member :beschreibung, type: String

    # @!attribute einzelpreis
    #   @return [String] Unit price
    member :einzelpreis, type: String

    # @!attribute menge
    #   @return [String] Quantity
    member :menge, type: String

    # Generates XML representation of the position
    # @param xml [Builder::XmlMarkup] XML builder instance
    # @return [void]
    def to_xml(xml)
      attributes = {
        Art: art,
        Nummer: nummer,
        Beschreibung: beschreibung,
        Einzelpreis: einzelpreis,
        Menge: menge
      }.compact # Removes nil values

      xml.Position(attributes)
    end
  end
end
