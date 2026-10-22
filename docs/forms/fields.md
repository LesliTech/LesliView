# Form fields

The builder exposes complete field wrappers that combine a label, input, optional icon, and help or validation message.

| Helper | Control |
| --- | --- |
| `field_control` / `field_control_text` | Text input |
| `field_control_email` | Email input |
| `field_control_password` | Password input |
| `field_control_checkbox` | Checkbox and label |
| `field_control_select` / `field_select` | Select menu |
| `field_control_textarea` / `field_textarea` | Plain textarea |
| `field_control_textarea_rich` | Lexxy rich textarea |
| `field_control_submit` | Rails submit control |
| `field_control_button` | Configurable button with optional icon |

```erb
<%= form.field_control_text(
    :subject,
    label: "Ticket subject",
    message: @ticket.errors[:subject].first,
    category: :danger,
    icon: "title",
    required: true
) %>
```

Input-specific keyword arguments are passed to the underlying Rails helper. Use `horizontal: true` on an individual field or select the horizontal builder for the complete form. Select helpers humanize choice labels by default; pass `humanize: false` to preserve them exactly.
