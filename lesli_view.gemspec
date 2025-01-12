# frozen_string_literal: true

require_relative "lib/lesli_view/version"

Gem::Specification.new do |spec|
    spec.name = "lesli_view"
    spec.version = LesliView::VERSION
    spec.authors = ["Luis Donis"]
    spec.email = ["ldonis.emc2@gmail.com"]

    spec.summary = "Lesli View elements"
    spec.description = "Lesli View elements"
    spec.homepage = "https://www.lesli.dev"
    spec.license = "MIT"
    spec.required_ruby_version = ">= 2.6.0"

    #spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/LesliTech/Lesli"
    spec.metadata["changelog_uri"] = "https://github.com/LesliTech/Lesli"

    # Specify which files should be added to the gem when it is released.
    # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
    spec.files = Dir.chdir(File.expand_path(__dir__)) do
        Dir["{lib}/**/*", "license", "readme.md"]
    end

    spec.bindir = "exe"
    spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]

    # Uncomment to register a new dependency of your gem
    # spec.add_dependency "example-gem", "~> 1.0"

    # For more information and examples about making a new gem, check out our
    # guide at: https://bundler.io/guides/creating_gem.html


    spec.add_dependency("view_component")
end
