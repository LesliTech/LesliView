require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/components/timeline"

module LesliView
    module Components
        class TimelineTest < Minitest::Test
            def test_renders_a_responsive_timeline_with_tailwind_classes
                html = Timeline.new(
                    activities: activities,
                    icons: { created: "add_circle" }
                ).render_in(ActionView::Base.empty)

                assert_includes html, "grid-cols-[1.5rem_minmax(0,1fr)]"
                assert_includes html, "md:grid-cols-[minmax(8rem,auto)_1.5rem_minmax(0,1fr)]"
                assert_includes html, "md:text-right"
                assert_includes html, "left-1/2"
                assert_includes html, "-translate-x-1/2"
                assert_includes html, "group-last:hidden"
                assert_includes html, "add_circle"
                assert_includes html, "radio_button_checked"
                assert_includes html, "Account created"
                assert_equal 2, html.scan("<li ").length
                refute_includes html, "lesli-timeline-item"
                refute_includes html, "lesli-timeline-marker"
            end

            private

            def activities
                [
                    {
                        "date" => "October 8, 2026",
                        "icon" => "created",
                        "operation" => "Account created",
                        "description" => "The user account was created."
                    },
                    {
                        "date" => "October 9, 2026",
                        "operation" => "Profile updated",
                        "description" => "The profile information was updated."
                    }
                ]
            end
        end
    end
end
