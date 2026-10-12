require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/components/timeline"
require_relative "../../lib/lesli_view/items/activities"

class Date2
    def db_column(column, as:)
        "formatted_#{column}_as_#{as}"
    end
end unless defined?(Date2)

module ActivitiesTestApp
    class Resource
        attr_reader :activities

        def initialize(activities)
            @activities = activities
        end
    end

    class Association
        attr_reader :selected_columns, :order_options

        def initialize(records)
            @records = records
        end

        def select(*columns)
            @selected_columns = columns
            self
        end

        def order(options)
            @order_options = options
            self
        end

        def as_json
            @records
        end
    end
end

module LesliView
    module Items
        class ActivitiesTest < Minitest::Test
            def test_queries_and_renders_activities_with_tailwind_wrapper
                association = ActivitiesTestApp::Association.new(activity_records)
                resource = ActivitiesTestApp::Resource.new(association)

                html = Activities.new(resource, icons: { created: "add_circle" })
                    .render_in(ActionView::Base.empty)

                assert_includes association.selected_columns, :id
                assert_includes association.selected_columns, "description as operation"
                assert_includes association.selected_columns, "activity_code as icon"
                assert_includes association.selected_columns, "formatted_created_at_as_date"
                assert_equal({ id: :desc }, association.order_options)
                assert_includes html, "lesli-items-activities bg-white p-4 sm:p-8"
                assert_includes html, "Account created"
                assert_includes html, "add_circle"
                assert_includes html, "grid-cols-[1.5rem_minmax(0,1fr)]"
            end

            private

            def activity_records
                [
                    {
                        "date" => "October 11, 2026",
                        "icon" => "created",
                        "operation" => "Account created",
                        "description" => "The account is ready."
                    }
                ]
            end
        end
    end
end
