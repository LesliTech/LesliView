# Chart widget

`LesliView::Widgets::Chart` wraps a small bar or line chart in the standard dashboard-card presentation.

```erb
<%= render LesliView::Widgets::Chart.new(
    "Tickets",
    { "Open" => 12, "Pending" => 7, "Closed" => 19 },
    type: :bar
) %>
```

The data object must respond to `to_a` and produce label/value pairs. `type:` accepts `:bar` or `:line`; unsupported values fall back to `:bar`. `nil` or empty data renders the translated `No chart data` state.

The host application must load the Lesli chart JavaScript. Use the lower-level [chart components](/gems/view/charts/general) when you need several datasets, custom height, or database conversion.
