# Date widget

`LesliView::Widgets::Date` displays a date as a prominent day number with localized weekday, month, and year.

```erb
<%= render LesliView::Widgets::Date.new(Date.new(2026, 10, 5)) %>
```

The argument defaults to `Time.current`. Values responding to `to_date` and parseable strings are accepted; invalid values fall back to the current date. Weekday, month, and accessible labels use the active I18n locale.

## Component files

```text
lib/lesli_view/widgets/
    date.rb
    date/
        date.html.erb
        date.css
```

The Ruby API is unchanged. The sidecar stylesheet is imported by
`source/tailwind/view.css` and compiled into the existing LesliView stylesheet.
It uses semantic classes and unprefixed `@apply`, with global theme variables
provided by LesliAssets.
