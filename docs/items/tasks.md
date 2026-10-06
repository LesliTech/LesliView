# Tasks

`LesliView::Items::Tasks` renders a create form and checklist for a taskable resource.

```erb
<%= render LesliView::Items::Tasks.new(@ticket) %>
```

The resource must expose `id`, `tasks`, and a namespaced `Items::Task` model. The component derives the form scope from that model and posts to the polymorphic `items_tasks_path` route with `taskable_type` and `taskable_id`.

Each task must expose `id`, `title`, `done`, and `done?` and must be routable through `polymorphic_path(task)` for the PATCH action. Completed tasks render as disabled and cannot be toggled again through this component.

Use `LesliView::Items::Task.new(task, scope_key)` only when rendering an individual list item; the collection component supplies the required form scope automatically.
