# Tasks

`LesliView::Items::Tasks` renders a create form and checklist for a taskable resource.

```erb
<%= render LesliView::Items::Tasks.new(@ticket) %>
```

The resource must include `Lesli::Items::Tasks`. The component reads the task
class and association name configured by `lesli_tasks_setup`, then posts to the
polymorphic `items_tasks_path` route with `taskable_type` and `taskable_id`.
The resource page supplies the initial collection; tasks do not expose separate
index or show endpoints.

Pass an invalid task back to the component to preserve its title and display
validation errors:

```erb
<%= render LesliView::Items::Tasks.new(@ticket, task: @task) %>
```

Each task must expose `id`, `title`, `done`, and `done?` and must be routable
through `polymorphic_path(task)` for the PATCH action. Completed tasks remain
visually subdued but interactive.

The PATCH action toggles completion, so a finished task can be marked as
pending again after an accidental click.

Use `LesliView::Items::Task.new(task, scope_key)` only when rendering an individual list item; the collection component supplies the required form scope automatically.
