require "minitest/autorun"
require "rails/version"
require "active_model"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/forms/fields"
require_relative "../../lib/lesli_view/forms/inputs"
require_relative "../../lib/lesli_view/forms/fieldset"
require_relative "../../lib/lesli_view/forms/builder"
require_relative "../../lib/lesli_view/items/task"
require_relative "../../lib/lesli_view/items/tasks"

module TasksTestApp
    module Items
        class Task
            include ActiveModel::Model

            attr_accessor :id, :title, :done

            def persisted?
                id.present?
            end

            def done?
                done
            end
        end
    end

    class Ticket
        include ActiveModel::Model

        attr_accessor :id, :tasks

        def self.lesli_tasks_class
            TasksTestApp::Items::Task
        end

        def self.lesli_tasks_association_name
            :tasks
        end

        def persisted?
            id.present?
        end
    end

    class TicketWithTaskList < Ticket
        attr_accessor :task_list

        def self.lesli_tasks_association_name
            :task_list
        end
    end
end

module LesliView
    module Items
        class TasksTest < Minitest::Test
            def test_renders_create_form_and_task_states_with_tailwind_classes
                html = Tasks.new(resource).render_in(view_context)

                assert_includes html, "rounded-2xl border border-slate-200 bg-white"
                assert_includes html, "border-t border-slate-200"
                assert_includes html, "list-none space-y-3"
                assert_includes html, 'action="/items/tasks"'
                assert_includes html, 'action="/items/tasks/1"'
                assert_includes html, 'action="/items/tasks/2"'
                assert_includes html, "check_box_outline_blank"
                assert_includes html, "check_box"
                assert_includes html, "hover:border-slate-300"
                assert_includes html,
                    "lesli-items-tasks-task-done border-slate-200 bg-slate-50"
                assert_includes html, "text-slate-500 line-through"
                assert_includes html, "Prepare release notes"
                assert_includes html, "Publish release"
                assert_equal 2, html.scan(/<li\b/).length
                assert_equal 0, html.scan(/disabled="disabled"/).length
                assert_includes html, 'aria-pressed="true"'
                assert_includes html, "Mark task as incomplete"
                refute_includes html, "<style>"
                refute_includes html, "is-flex"
                refute_includes html, "icon-text"
            end

            def test_renders_the_configured_task_association
                custom_resource = TasksTestApp::TicketWithTaskList.new(
                    id: 43,
                    tasks: [],
                    task_list: [
                        TasksTestApp::Items::Task.new(
                            id: 3,
                            title: "Configured association",
                            done: false
                        )
                    ]
                )

                html = Tasks.new(custom_resource).render_in(view_context)

                assert_includes html, "Configured association"
                assert_equal 1, html.scan(/<li\b/).length
            end

            def test_renders_a_discreet_empty_state
                empty_resource = TasksTestApp::Ticket.new(id: 44, tasks: [])

                html = Tasks.new(empty_resource).render_in(view_context)

                assert_includes html, "No tasks have been added yet."
                assert_includes html, "text-slate-500"
            end

            def test_preserves_the_form_task_and_displays_its_errors
                invalid_task = TasksTestApp::Items::Task.new(
                    title: "Keep this title"
                )
                invalid_task.errors.add(:title, "is invalid")

                html = Tasks
                    .new(resource, task: invalid_task)
                    .render_in(view_context)

                assert_includes html, 'value="Keep this title"'
                assert_includes html, "Title is invalid"
            end

            private

            def resource
                TasksTestApp::Ticket.new(
                    id: 42,
                    tasks: [
                        TasksTestApp::Items::Task.new(id: 1, title: "Prepare release notes", done: false),
                        TasksTestApp::Items::Task.new(id: 2, title: "Publish release", done: true)
                    ]
                )
            end

            def view_context
                context = ActionView::Base.empty
                context.define_singleton_method(
                    :protect_against_forgery?
                ) { false }
                context.define_singleton_method(:polymorphic_path) do |target, **|
                    target.is_a?(Array) ?
                        "/items/tasks" :
                        "/items/tasks/#{target.id}"
                end
                context
            end
        end
    end
end
