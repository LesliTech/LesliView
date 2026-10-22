require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/elements/empty"
require_relative "../../lib/lesli_view/components/timeline"
require_relative "../../lib/lesli_view/items/activities"

module ActivitiesTestApp
    Actor = Struct.new(:full_name)
    Activity = Struct.new(
        :activity_code,
        :activity_type,
        :actor,
        :created_at,
        :description,
        :metadata,
        keyword_init: true
    )

    class Resource
        attr_reader :activities

        def initialize(activities)
            @activities = activities
        end
    end

    class Association
        attr_reader :included_associations, :limit_value, :order_options

        def initialize(records)
            @records = records
        end

        def includes(*associations)
            @included_associations = associations
            self
        end

        def reorder(options)
            @order_options = options
            self
        end

        def limit(value)
            @limit_value = value
            @records.first(value)
        end
    end
end

module LesliView
    module Items
        class ActivitiesTest < Minitest::Test
            def test_queries_a_limited_scope_and_renders_presented_activities
                association = ActivitiesTestApp::Association.new(activity_records)
                resource = ActivitiesTestApp::Resource.new(association)

                html = Activities.new(
                    resource,
                    icons: { account_created: "add_circle" },
                    limit: 10
                ).render_in(ActionView::Base.empty)

                assert_equal [:actor], association.included_associations
                assert_equal({ created_at: :desc, id: :desc }, association.order_options)
                assert_equal 10, association.limit_value
                assert_includes html, "lesli-items-activities bg-white p-4 sm:p-8"
                assert_includes html, "Account created"
                assert_includes html, "The account is ready."
                assert_includes html, "Ada Lovelace"
                assert_includes html, "2026-10-11 · 09:30"
                assert_includes html, "add_circle"
            end

            def test_rejects_a_non_positive_limit
                resource = ActivitiesTestApp::Resource.new(
                    ActivitiesTestApp::Association.new([])
                )

                assert_raises(ArgumentError) do
                    Activities.new(resource, limit: 0)
                end
            end

            def test_uses_the_configured_translation_scope
                I18n.backend.store_translations(:en, {
                    custom_activity: {
                        empty: "Nothing happened yet.",
                        unknown_actor: "System",
                        events: {
                            account_created: {
                                operation: "Custom account event",
                                description: "Custom event description"
                            }
                        }
                    }
                })
                resource = ActivitiesTestApp::Resource.new(
                    ActivitiesTestApp::Association.new(activity_records)
                )

                component = Activities.new(
                    resource,
                    i18n_scope: "custom_activity"
                )

                assert_equal "Custom account event",
                    component.activities.first["operation"]
                assert_equal "Custom event description",
                    component.activities.first["description"]
            end

            private

            def activity_records
                [
                    ActivitiesTestApp::Activity.new(
                        activity_code: "account_created",
                        activity_type: "activity",
                        actor: ActivitiesTestApp::Actor.new("Ada Lovelace"),
                        created_at: Time.new(2026, 10, 11, 9, 30, 0, "+00:00"),
                        description: "The account is ready.",
                        metadata: {}
                    )
                ]
            end
        end
    end
end
