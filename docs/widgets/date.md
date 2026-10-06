# Date widget

`LesliView::Widgets::Date` displays a date as a prominent day number with localized weekday, month, and year.

```erb
<%= render LesliView::Widgets::Date.new(Date.new(2026, 10, 5)) %>
```

The argument defaults to `Time.current`. Values responding to `to_date` and parseable strings are accepted; invalid values fall back to the current date. Weekday, month, and accessible labels use the active I18n locale.
