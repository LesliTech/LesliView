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
                assert_includes html, "translate-x-8 opacity-0"
                assert_includes html, "duration-150"
                assert_includes html, "duration-100"
                refute_includes html, "duration-300"
                assert_includes html, "w-full"
                assert_includes html, "h-dvh"
                assert_includes html, "max-h-dvh"
                assert_includes html, "overscroll-contain"
                assert_includes html, "size-11"
                assert_includes html, "sm:max-w-2xl"
                assert_includes html, "Editor content"
            end

            def test_can_render_without_an_overlay
                html = Panel.new("Details", "details-panel", overlay: false)
                    .render_in(ActionView::Base.empty)

                refute_includes html, "bg-slate-950/25"
                assert_includes html, 'role="dialog"'
                assert_includes html, 'aria-modal="false"'
            end
        end
    end
end
