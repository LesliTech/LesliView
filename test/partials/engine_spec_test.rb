require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/partials/engine_spec"

module LesliDate
    class Formatter
        def initialize(*)
        end

        def date_time
            "October 9, 2026 10:30"
        end
    end unless const_defined?(:Formatter)
end

module LesliView
    module Partials
        class EngineSpecTest < Minitest::Test
            def test_renders_engine_metadata_with_tailwind_classes
                html = EngineSpec.new(engine).render_in(ActionView::Base.empty)

                assert_includes html, "border-b border-slate-300"
                assert_includes html, "text-xl font-semibold"
                assert_includes html, "list-none space-y-2"
                assert_includes html, "flex items-center gap-2"
                assert_includes html, "LesliShield"
                assert_includes html, "Version: 1.2.3"
                assert_includes html, "Build: October 9, 2026 10:30"
                assert_includes html, 'target="_blank"'
                assert_includes html, 'rel="noopener noreferrer"'
                assert_includes html, "https://example.com/docs"
                refute_includes html, "<style>"
                refute_includes html, "is-size-5"
                refute_includes html, "icon-text"
            end

            private

            def engine
                {
                    name: "LesliShield",
                    summary: "Authentication and authorization",
                    version: "1.2.3",
                    build: 1_780_000_000,
                    metadata: { "documentation_uri" => "https://example.com/docs" }
                }
            end
        end
    end
end
