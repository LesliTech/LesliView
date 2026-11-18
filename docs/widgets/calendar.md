# Calendar widget

`LesliView::Widgets::Calendar` renders one compact month without navigation controls.

```erb
<%= render LesliView::Widgets::Calendar.new(
    "October schedule",
    date: Date.new(2026, 10, 1),
    selected_date: Date.new(2026, 10, 5),
    events: [Date.new(2026, 10, 5), Date.new(2026, 10, 12)],
    week_starts_on: :monday
) %>
```

`date:` selects the displayed month, `events:` adds markers, and `selected_date:` highlights one day. Values responding to `to_date` and parseable strings are accepted. `week_starts_on:` supports `:sunday` and `:monday`; invalid values fall back to Sunday. The optional second positional `number` remains accepted for compatibility but does not affect the rendered calendar.

## Component files

```text
lib/lesli_view/widgets/
    calendar.rb
    calendar/
        calendar.html.erb
        calendar.css
```

The Ruby API is unchanged. The sidecar stylesheet is imported by
`source/tailwind/view.css` and compiled into the existing LesliView stylesheet.
It uses semantic classes and unprefixed `@apply`, with global theme variables
provided by LesliAssets.
