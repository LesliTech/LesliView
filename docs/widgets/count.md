# Count widget

`LesliView::Widgets::Count` displays one prominent metric with an optional title.

```erb
<%= render LesliView::Widgets::Count.new("Open tickets", 42) %>
```

The first positional argument is the title and the second is the displayed value. A `nil` value renders an em dash instead of an ambiguous zero.

## Component files

```text
lib/lesli_view/widgets/
    count.rb
    count/
        count.html.erb
        count.css
```

The Ruby API is unchanged. The sidecar stylesheet is imported by
`source/tailwind/view.css` and compiled into the existing LesliView stylesheet.
It uses semantic classes and unprefixed `@apply`, with global theme variables
provided by LesliAssets.
