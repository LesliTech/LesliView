# Button

`LesliView::Elements::Button` renders a button, link, or Rails `button_to` according to its options.

```erb
<%= render LesliView::Elements::Button.new(
    "Create ticket",
    url: new_ticket_path,
    icon: "add",
    success: true,
    info: false
) %>
```

| Option | Default | Purpose |
| --- | --- | --- |
| `url:` | `nil` | Renders a link when present |
| `method:` | `nil` | Renders `button_to` for non-GET actions |
| `icon:` | `nil` | Material Symbol name |
| `solid:`, `light:`, `small:` | Style defaults | Presentation modifiers |
| `info:`, `success:`, `warning:`, `danger:` | Info enabled | Semantic variant; warning, success, and danger take precedence |
| `loading:` | `false` | Shows loading style and disables activation |
| `disabled:` | `false` | Disables a button or renders a non-interactive link substitute |
| `dispatch:` | `nil` | Dispatches an Alpine event on click |
| `params:` | `nil` | Parameters passed to `button_to` |
| `data:` | `{}` | Merged with the default top-level Turbo target |

For an icon-only button, pass `aria_label:` when the humanized icon name does not adequately describe the action. A component block can supply the visible label instead of the first argument.
