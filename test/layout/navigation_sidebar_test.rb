require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/layout/navigation_sidebar"

class NavigationSidebarTest < Minitest::Test
    def test_renders_selected_links_in_both_responsive_presentations
        component = LesliView::Layout::NavigationSidebar.new(
            label: "Modules",
            items: [{ label: "Shield", path: "/roles/2/actions?search=show", selected: true, count: 0 }]
        )
        html = component.render_in(ActionView::Base.empty)
        assert_equal 2, html.scan('aria-current="page"').size
        assert_equal 2, html.scan('data-turbo-frame="_top"').size
        assert_includes html, "/roles/2/actions?search=show"
        assert_includes html, "lg:w-60"
        assert_includes html, "lg:sticky"
        assert_includes html, "lesli-navigation-sidebar-desktop"
        assert_includes html, "lesli-navigation-sidebar-mobile"
        refute_match(/class="hidden /, html)
        assert_includes html, "<summary"
        assert_includes html, ">0</span>"
        assert_equal "Shield", component.selected_label
    end

    def test_escapes_labels_and_supports_empty_navigation
        component = LesliView::Layout::NavigationSidebar.new(
            items: [], label: "Modules", empty_selection_label: "<script>alert(1)</script>"
        )
        html = component.render_in(ActionView::Base.empty)
        refute_includes html, "<script>"
        assert_includes html, "&lt;script&gt;"
        refute_includes html, 'aria-current="page"'
        assert_equal "Modules", LesliView::Layout::NavigationSidebar.new(items: [], label: "Modules").selected_label
    end
end
