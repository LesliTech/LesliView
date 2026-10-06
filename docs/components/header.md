# Header

`LesliView::Components::Header` renders a page title, optional subtitle, back action, primary create action, and additional block content.

```erb
<%= render LesliView::Components::Header.new(
    "Tickets",
    "Manage customer requests.",
    back: tickets_path,
    new_path: new_ticket_path,
    new_label: "Create ticket"
) do %>
    <%= render LesliView::Elements::Button.new("Export", url: exports_path) %>
<% end %>
```

| Option | Default | Purpose |
| --- | --- | --- |
| First argument | Required | Page title |
| Second argument | `nil` | Subtitle |
| `back:` | `nil` | Back URL; `true` uses the referrer and falls back to `/` |
| `new_path:` | `nil` | Shows the primary create action |
| `new_label:` | Translated `actions.new` or `New` | Create-action label |

Block content is rendered in the page-actions group. The back action targets the top Turbo frame, and visible actions include accessible labels.
