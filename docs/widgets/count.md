# Count widget

`LesliView::Widgets::Count` displays one prominent metric with an optional title.

```erb
<%= render LesliView::Widgets::Count.new("Open tickets", 42) %>
```

The first positional argument is the title and the second is the displayed value. A `nil` value renders an em dash instead of an ambiguous zero.
