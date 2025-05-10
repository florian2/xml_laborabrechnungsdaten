module XmlLaborabrechnungsdaten
  class Rechnung
    include MemberContainer

    # @!attribute laborname
    #   @return [String]
    member :laborname, type: String

    # @!attribute labor_id
    #   @return [String]
    member :labor_id, type: String

    # @!attribute herstellungsort
    #   @return [String]
    member :herstellungsort, type: String

    # @!attribute abrechnungsbereich
    #   @return [String]
    member :abrechnungsbereich, type: String

    # @!attribute laborlieferdatum
    #   @return [String]
    member :laborlieferdatum, type: String

    # @!attribute laborrechnungsnummer
    #   @return [String]
    member :laborrechnungsnummer, type: String

    # @!attribute auftragsnummer
    #   @return [String]
    member :auftragsnummer, type: String

    # @!attribute gesamtbetrag_netto
    #   @return [String]
    member :gesamtbetrag_netto, type: String

    # @!attribute mehrwertsteuer_gesamt
    #   @return [String]
    member :mehrwertsteuer_gesamt, type: String

    # @!attribute gesamtbetrag_brutto
    #   @return [String]
    member :gesamtbetrag_brutto, type: String

    # @!attribute laborsoftwarehersteller
    #   @return [String]
    member :laborsoftwarehersteller, type: String

    # @!attribute laborsoftware
    #   @return [String]
    member :laborsoftware, type: String

    # @!attribute laborsoftwareversion
    #   @return [String]
    member :laborsoftwareversion, type: String

    # @!attribute mwst_gruppen
    #   @return [Array<MwstGruppe>] List of VAT groups in this invoice
    member :mwst_gruppen, type: Array, default: []

    # Adds a VAT group to the invoice
    # @param mwst_gruppe [MwstGruppe] VAT group to add
    # @return [Array<MwstGruppe>] Updated list of VAT groups
    def add_mwst_gruppe(mwst_gruppe)
      @mwst_gruppen ||= []
      @mwst_gruppen << mwst_gruppe
      @mwst_gruppen
    end

    # Generates XML representation of the invoice
    # @param xml [Builder::XmlMarkup] XML builder instance
    # @return [void]
    def to_xml(xml)
      attributes = {
        Laborsoftwarehersteller: laborsoftwarehersteller,
        Laborsoftware: laborsoftware,
        Laborsoftwareversion: laborsoftwareversion,
        Laborname: laborname,
        "Labor-ID": labor_id,
        Herstellungsort: herstellungsort,
        Abrechnungsbereich: abrechnungsbereich,
        Laborlieferdatum: laborlieferdatum,
        Laborrechnungsnummer: laborrechnungsnummer,
        Auftragsnummer: auftragsnummer,
        Gesamtbetrag_netto: gesamtbetrag_netto,
        Mehrwertsteuer_gesamt: mehrwertsteuer_gesamt,
        Gesamtbetrag_brutto: gesamtbetrag_brutto
      }.compact # Removes nil values

      xml.Rechnung(attributes) do
        # Add all VAT groups as child elements
        mwst_gruppen.each do |mwst_gruppe|
          mwst_gruppe.to_xml(xml)
        end
      end
    end
  end
end
