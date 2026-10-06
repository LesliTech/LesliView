# Actions

`LesliView::Items::Actions` renders an action create form and a checklist for a resource.

```erb
<%= render LesliView::Items::Actions.new(
    @ticket,
    path_to_create: ticket_actions_path(@ticket),
    path_to_update: ->(id) { ticket_action_path(@ticket, id) }
) %>
```

The resource must expose an `actions` association whose records provide `id`, `title`, `done`, and `done?`. `path_to_create:` is used by the new-action form. `path_to_update:` must be callable with an action ID and return the PATCH URL.

Both paths are required by the current template even though the initializer accepts `nil`. Completed actions render disabled and cannot be toggled again through this component.
