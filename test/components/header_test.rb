require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/components/header"

module LesliView
    module Components
        class HeaderTest < Minitest::Test
            def test_places_the_title_and_actions_in_adaptive_top_aligned_columns
                html = Header.new("Users", "Manage user accounts")
                    .render_in(ActionView::Base.empty) { "Export" }

                assert_includes html, "lesli-header"
                assert_includes html, 'class="lesli-header-text"'
                assert_includes html, "lesli-header-actions"
                assert_operator html.index("Users"), :<, html.index("Export")
            end
        end
    end
end
