require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/forms/fields"
require_relative "../../lib/lesli_view/forms/inputs"
require_relative "../../lib/lesli_view/forms/fieldset"
require_relative "../../lib/lesli_view/forms/builder"
require_relative "../../lib/lesli_view/items/discussion"
require_relative "../../lib/lesli_view/items/discussions"

module DiscussionsTestApp
    module Items
        class Discussion
        end
    end

    class Ticket
        attr_reader :id, :discussions

        def initialize(id:, discussions:)
            @id = id
            @discussions = Association.new(discussions)
        end
    end

    class Association
        def initialize(records)
            @records = records
        end

        def order(created_at:)
            raise ArgumentError, "expected descending order" unless created_at == :desc

            @records
        end
    end

    DiscussionRecord = Struct.new(:message, :created_at_string) do
        def [](key)
            public_send(key)
        end
    end
end

module LesliView
    module Items
        class DiscussionsTest < Minitest::Test
            def test_renders_the_form_and_discussion_list_with_tailwind_classes
                view_context = ActionView::Base.empty
                view_context.define_singleton_method(:polymorphic_path) { |*, **| "/items/discussions" }
                view_context.define_singleton_method(:protect_against_forgery?) { false }

                html = Discussions.new(resource).render_in(view_context)

                assert_includes html, "bg-white p-4 sm:p-8"
                assert_includes html, "border-t border-slate-200"
                assert_includes html, "list-none space-y-6"
                assert_includes html, "sm:flex-row"
                assert_includes html, "sm:text-right"
                assert_includes html, "whitespace-pre-wrap break-words"
                assert_includes html, "A plain-text comment"
                assert_includes html, "&lt;strong&gt;markup&lt;/strong&gt;"
                refute_includes html, "<strong>markup</strong>"
                refute_includes html, "lexxy-content"
                assert_includes html, "October 11, 2026"
                assert_includes html, 'action="/items/discussions"'
                assert_match(/<textarea[^>]*rows="4"/, html)
                assert_match(/<ul[^>]*>.*<li.*<\/li>.*<\/ul>/m, html)
                refute_includes html, "is-flex"
                refute_includes html, "has-text-right"
                refute_includes html, "is-fullwidth"
            end

            private

            def resource
                discussion = DiscussionsTestApp::DiscussionRecord.new(
                    "A plain-text comment\nwith <strong>markup</strong>",
                    "October 11, 2026"
                )

                DiscussionsTestApp::Ticket.new(id: 42, discussions: [discussion])
            end
        end
    end
end
