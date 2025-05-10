require_relative "xml_laborabrechnungsdaten/version"
require_relative "xml_laborabrechnungsdaten/member_container"
require_relative "xml_laborabrechnungsdaten/rechnung"
require_relative "xml_laborabrechnungsdaten/mwst_gruppe"
require_relative "xml_laborabrechnungsdaten/position"
require "builder"

module XmlLaborabrechnungsdaten
  class Error < StandardError; end

  class Document
    include MemberContainer

    # @!attribute version
    #   @return [String] Version of the XML schema
    member :version, type: String, default: "4.5"

    # @!attribute rechnung
    #   @return [Rechnung] The invoice details
    member :rechnung, type: Rechnung

    # Generates the complete XML document
    # @param indent [Integer] Indentation level for pretty printing
    # @param target [String, IO] The output target
    # @return [String] The generated XML
    def to_xml(indent: 2, target: "")
      xml = Builder::XmlMarkup.new(indent: indent, target: target)
      xml.instruct! :xml, version: "1.0", encoding: "UTF-8"

      # Root element with namespaces and schema location
      xml.Laborabrechnung(
        "xsi:noNamespaceSchemaLocation" => "Laborabrechnungsdaten_(KZBV-VDZI-VDDS)_(V4-5).xsd",
        "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
        "Version" => version
      ) do
        # Add the invoice if it exists
        rechnung&.to_xml(xml)
      end

      target
    end
  end
end
