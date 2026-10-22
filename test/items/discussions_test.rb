require "minitest/autorun"
require "rails/version"
require "active_model"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/forms/fields"
require_relative "../../lib/lesli_view/forms/inputs"
require_relative "../../lib/lesli_view/forms/fieldset"
require_relative "../../lib/lesli_view/forms/builder"
require_relative "../../lib/lesli_view/items/discussion"
require_relative "../../lib/lesli_view/items/discussions"

module DiscussionsTestApp
    Author = Struct.new(:full_name, :name)

    module Items
        class Discussion
            include ActiveModel::Model

            attr_accessor :author, :created_at, :id, :message

            def persisted?
                id.present?
            end
        end
    end

    class Ticket
        include ActiveModel::Model

        attr_accessor :comments, :discussions, :id

        def self.lesli_discussions_class
            DiscussionsTestApp::Items::Discussion
        end

        def self.lesli_discussions_association_name
            :discussions
        end

        def persisted?
            id.present?
        end
    end

    class TicketWithComments < Ticket
        def self.lesli_discussions_association_name
            :comments
        end
    end
end

module LesliView
    module Items
        class DiscussionsTest < Minitest::Test
            def test_renders_a_linear_comment_with_author_and_timestamp
                html = Discussions.new(resource).render_in(view_context)

                assert_includes html, "bg-white p-4 sm:p-8"
                assert_includes html, "border-t border-slate-200"
                assert_includes html, "list-none space-y-6"
                assert_includes html, "sm:flex-row"
                assert_includes html, "sm:text-right"
                assert_includes html, "whitespace-pre-wrap break-words"
                assert_includes html, "Ada Lovelace"
                assert_includes html, "2026-10-11 · 16:30"
                assert_includes html,
                    'datetime="2026-10-11T16:30:00+00:00"'
                assert_match(/<ul[^>]*>.*<li.*<\/li>.*<\/ul>/m, html)
            end

            def test_renders_the_message_as_escaped_plain_text
                html = Discussions.new(resource).render_in(view_context)

                assert_includes html, "A plain-text comment"
                assert_includes html, "&lt;strong&gt;markup&lt;/strong&gt;"
                refute_includes html, "<strong>markup</strong>"
                refute_includes html, "lexxy-content"
            end

            def test_renders_the_configured_form
                html = Discussions.new(resource).render_in(view_context)

                assert_includes html, 'action="/items/discussions"'
                assert_includes html,
                    'name="discussions_test_app_items_discussion[message]"'
                assert_match(/<textarea[^>]*rows="4"/, html)
            end

            def test_renders_the_configured_discussion_association
                custom_resource = DiscussionsTestApp::TicketWithComments.new(
                    id: 43,
                    discussions: [],
                    comments: [discussion(message: "Configured association")]
                )

                html = Discussions.new(custom_resource).render_in(view_context)

                assert_includes html, "Configured association"
                assert_equal 1, html.scan(/<li\b/).length
            end

            def test_renders_a_discreet_empty_state
                empty_resource = DiscussionsTestApp::Ticket.new(
                    id: 44,
                    discussions: []
                )

                html = Discussions.new(empty_resource).render_in(view_context)

                assert_includes html, "No comments have been added yet."
                assert_includes html, "text-slate-500"
            end

            def test_preserves_the_form_message_and_displays_its_errors
                invalid_comment = DiscussionsTestApp::Items::Discussion.new(
                    message: "Keep this comment"
                )
                invalid_comment.errors.add(:message, "is invalid")

                html = Discussions
                    .new(resource, comment: invalid_comment)
                    .render_in(view_context)

                assert_match(
                    /<textarea[^>]*>\s*Keep this comment<\/textarea>/,
                    html
                )
                assert_includes html, "Message is invalid"
            end

            def test_uses_the_translated_unknown_author_fallback
                anonymous_resource = DiscussionsTestApp::Ticket.new(
                    id: 45,
                    discussions: [discussion(message: "Anonymous", author: nil)]
                )

                html = Discussions.new(anonymous_resource).render_in(view_context)

                assert_includes html, "Unknown user"
            end

            private

            def discussion(message:, author: default_author)
                DiscussionsTestApp::Items::Discussion.new(
                    id: 1,
                    author: author,
                    created_at: Time.utc(2026, 10, 11, 16, 30),
                    message: message
                )
            end

            def default_author
                DiscussionsTestApp::Author.new("Ada Lovelace", "Ada")
            end

            def resource
                DiscussionsTestApp::Ticket.new(
                    id: 42,
                    discussions: [
                        discussion(
                            message: "A plain-text comment\nwith <strong>markup</strong>"
                        )
                    ]
                )
            end

            def view_context
                context = ActionView::Base.empty
                context.define_singleton_method(
                    :protect_against_forgery?
                ) { false }
                context.define_singleton_method(
                    :polymorphic_path
                ) { |*, **| "/items/discussions" }
                context
            end
        end
    end
end
