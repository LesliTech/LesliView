require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/components/panel"

module LesliView
    module Components
        class PanelTest < Minitest::Test
            def test_renders_an_accessible_responsive_sliding_panel
                html = Panel.new("Translation editor", "translation-panel")
                    .render_in(ActionView::Base.empty) { "Editor content" }

                assert_includes html, 'id="translation-panel-panel"'
                assert_includes html, '@translation-panel.window="openPanel()"'
                assert_includes html, '@keydown.escape.window="if (open) closePanel()"'
                assert_includes html, 'role="dialog"'
                assert_includes html, 'aria-modal="true"'
                assert_includes html, 'aria-labelledby="translation-panel-title"'
                assert_includes html, 'aria-label="Close panel"'
                assert_includes html, "lesli-panel-hidden"
                assert_includes html, "lesli-panel-entering"
                assert_includes html, "lesli-panel-leaving"
                refute_includes html, "duration-300"
                assert_includes html, "lesli-panel-dialog"
                assert_includes html, "lesli-panel-close"
                assert_includes html, "Editor content"
            end

            def test_can_render_without_an_overlay
                html = Panel.new("Details", "details-panel", overlay: false)
                    .render_in(ActionView::Base.empty)

                refute_includes html, "lesli-panel-overlay"
                assert_includes html, 'aria-modal="false"'
            end
        end
    end
end
