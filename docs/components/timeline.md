# Timeline

`LesliView::Components::Timeline` renders activity hashes in chronological presentation.

```erb
<%= render LesliView::Components::Timeline.new(
    activities: [
        { "date" => "Oct 5, 2026", "operation" => "Ticket created", "icon" => "create" }
    ],
    icons: { create: "add_circle" }
) %>
```

Each activity should provide string keys for `date`, `operation`, optional `description`, and optional `icon`. The `icons:` hash maps activity codes to Material Symbol names; unknown codes use `radio_button_checked`. Pass an array, not `nil`, when rendering the component directly.
