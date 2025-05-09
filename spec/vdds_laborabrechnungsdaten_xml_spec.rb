# frozen_string_literal: true

RSpec.describe VddsLaborabrechnungsdatenXml do
  subject(:doc) do
    VddsLaborabrechnungsdatenXml::Document.new
  end

  it "has a version number" do
    expect(VddsLaborabrechnungsdatenXml::VERSION).not_to be nil
  end

  it "generates valid XML" do
    # Set up document attributes
    doc.version = "4.5"

    # Create and configure the invoice
    rechnung = VddsLaborabrechnungsdatenXml::Rechnung.new
    rechnung.laborsoftwarehersteller = "DentaTool UG (www.dentatool.de)"
    rechnung.laborsoftware = "DentaTool"
    rechnung.laborname = "Dentallabor Test"
    rechnung.herstellungsort = "D-Berlin"
    rechnung.abrechnungsbereich = "BE"
    rechnung.laborlieferdatum = "2025-05-09"
    rechnung.laborrechnungsnummer = "20251234"
    rechnung.auftragsnummer = "289202-600-ZE-8040-30-3"
    rechnung.gesamtbetrag_netto = "10919"
    rechnung.mehrwertsteuer_gesamt = "764"
    rechnung.gesamtbetrag_brutto = "11683"

    # Create and configure the VAT group
    mwst_gruppe = VddsLaborabrechnungsdatenXml::MwstGruppe.new
    mwst_gruppe.zwischensumme_netto = "10919"
    mwst_gruppe.mehrwertsteuersatz = "70"
    mwst_gruppe.mehrwertsteuerbetrag = "764"

    # Create and add positions
    positions_data = [
      { art: "BEL", nummer: "0010", beschreibung: "Modell", einzelpreis: "806", menge: "2000" },
      { art: "BEL", nummer: "0112", beschreibung: "Fixator", einzelpreis: "1050", menge: "1000" },
      { art: "BEL", nummer: "8090", beschreibung: "Vollständige Unterfütterung", einzelpreis: "6887", menge: "1000" },
      { art: "BEL", nummer: "9330", beschreibung: "Versandkosten", einzelpreis: "685", menge: "2000" }
    ]

    positions_data.each do |pos_data|
      position = VddsLaborabrechnungsdatenXml::Position.new
      position.art = pos_data[:art]
      position.nummer = pos_data[:nummer]
      position.beschreibung = pos_data[:beschreibung]
      position.einzelpreis = pos_data[:einzelpreis]
      position.menge = pos_data[:menge]
      mwst_gruppe.add_position(position)
    end

    # Connect everything together
    rechnung.add_mwst_gruppe(mwst_gruppe)
    doc.rechnung = rechnung

    expected = File.read("spec/fixtures/sample_xml1.xml")

    # Remove XML comments
    expected.gsub!(/\s*<!--.+?-->/mi, "")

    expect(doc.to_xml).to eq(expected)
  end
end
