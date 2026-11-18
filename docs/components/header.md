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

The title and actions remain in two top-aligned columns. The title section uses
the available width while the actions section keeps the width required by its
content.

## Component files

```text
lib/lesli_view/components/
    header.rb
    header/
        header.html.erb
        header.css
```

The Ruby API is unchanged. The sidecar stylesheet uses semantic classes and
unprefixed `@apply`, and is imported by `source/tailwind/view.css` into the
existing LesliView stylesheet. Global theme variables remain in LesliAssets.
