require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/elements/empty"
require_relative "../../lib/lesli_view/components/timeline"

module LesliView
    module Components
        class TimelineTest < Minitest::Test
            def test_renders_event_actor_date_description_and_icons
                html = Timeline.new(
                    activities: activities,
                    icons: { created: "add_circle" }
                ).render_in(ActionView::Base.empty)

                assert_includes html, "grid-cols-[1.5rem_minmax(0,1fr)]"
                assert_includes html, "md:grid-cols-[minmax(8rem,auto)_1.5rem_minmax(0,1fr)]"
                assert_includes html, "group-last:hidden"
                assert_includes html, "add_circle"
                assert_includes html, "radio_button_checked"
                assert_includes html, "Account created"
                assert_includes html, "The user account was created."
                assert_includes html, "Ada Lovelace"
                assert_includes html, "October 8, 2026"
                assert_equal 2, html.scan("<li ").length
            end

            def test_renders_an_empty_state
                html = Timeline.new(
                    activities: [],
                    empty_text: "No ticket activity yet."
                ).render_in(ActionView::Base.empty)

                assert_includes html, "lesli-empty-state"
                assert_includes html, "No ticket activity yet."
                refute_includes html, "<li "
            end

            private

            def activities
                [
                    {
                        "actor" => "Ada Lovelace",
                        "date" => "October 8, 2026",
                        "description" => "The user account was created.",
                        "icon" => "created",
                        "operation" => "Account created"
                    },
                    {
                        "actor" => "Grace Hopper",
                        "date" => "October 9, 2026",
                        "operation" => "Profile updated"
                    }
                ]
            end
        end
    end
end
