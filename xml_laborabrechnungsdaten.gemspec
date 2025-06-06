# frozen_string_literal: true

require_relative "lib/xml_laborabrechnungsdaten/version"

Gem::Specification.new do |spec|
  spec.name = "xml_laborabrechnungsdaten"
  spec.version = XmlLaborabrechnungsdaten::VERSION
  spec.authors = ["Florian Görsdorf"]
  spec.email = ["florian.goersdorf@dentatool.de"]

  spec.summary = "Library to create XML invoice representations of dental labs invoices following the german VDDS XML exchange standart between dental practices and dental labs"
  spec.description = "A ruby gem to generate XML for invoice exchange between dental lab and dentist practices following the standard from VDDS, KZBV and VDZI."
  spec.homepage = "https://github.com/florian2/xml_laborabrechnungsdaten"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "builder", "~> 3.2"
  spec.add_development_dependency "debug", ">= 1.0.0"
end
