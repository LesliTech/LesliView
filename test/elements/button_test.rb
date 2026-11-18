require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/elements/button"

module LesliView
    module Elements
        class ButtonTest < Minitest::Test
            def test_primary_is_the_default_for_every_presentation
                [{}, { solid: false }, { light: true }, { url: "/settings" }].each do |options|
                    button = Button.new("Settings", **options)
                    assert_includes button.html_classes.split, "is-primary"
                    refute_includes button.html_classes.split, "is-info"
                end
            end

            def test_semantic_variants_require_an_explicit_option
                %i[info success warning danger].each do |variant|
                    button = Button.new("Action", **{ variant => true })
                    assert_equal "is-#{variant}", button.button_variant
                end
            end
        end
    end
end
