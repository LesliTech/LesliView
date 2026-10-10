require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/components/header"

module LesliView
    module Components
        class HeaderTest < Minitest::Test
            def test_places_the_title_and_actions_on_opposite_sides_at_desktop_widths
                html = Header.new("Users", "Manage user accounts")
                    .render_in(ActionView::Base.empty) { "Export" }

                assert_includes html, "grid w-full grid-cols-1"
                assert_includes html, "md:grid-cols-[minmax(0,1fr)_auto]"
                assert_includes html, 'class="min-w-0"'
                assert_includes html, "md:justify-self-end"
                assert_operator html.index("Users"), :<, html.index("Export")
            end
        end
    end
end
