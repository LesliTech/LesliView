require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/components/tabs"

module LesliView
    module Components
        class TabsTest < Minitest::Test
            def test_renders_accessible_horizontal_tabs_with_tailwind_classes
                html = render_tabs

                assert_includes html, 'role="tablist"'
                assert_includes html, 'aria-orientation="horizontal"'
                assert_equal 2, html.scan('role="tab"').length
                assert_includes html, 'id="activity-tab"'
                assert_includes html, 'aria-controls="activity"'
                assert_includes html, 'role="tabpanel"'
                assert_includes html, "border-slate-200"
                assert_includes html, "border-blue-600 text-blue-700"
                assert_includes html, "cursor-pointer"
                refute_includes html, "bg-blue-50"
                refute_includes html, "hover:bg-slate-50"
                refute_includes html, "is-active"
                refute_includes html, 'class="tabs'
            end

            def test_renders_the_vertical_presentation
                html = render_tabs(vertical: true)

                assert_includes html, "lesli-tabs min-w-0 flex items-start gap-6"
                assert_includes html, 'aria-orientation="vertical"'
                assert_includes html, "flex w-full flex-col border-r"
                assert_includes html, "w-full border-r-2 text-left"
            end

            private

            def render_tabs(vertical: false)
                component = Tabs.new(active_tab: "activity", vertical: vertical)
                component.with_tab(id: "details", title: "Details") { "Ticket details" }
                component.with_tab(id: "activity", title: "Activity", icon: "history") { "Recent changes" }
                component.render_in(ActionView::Base.empty)
            end
        end
    end
end
