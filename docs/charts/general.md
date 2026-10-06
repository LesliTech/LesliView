# General chart

`LesliView::Charts::General` is the shared ViewComponent base for Lesli charts. Applications normally render `Bar` or `Line`; subclasses supply the Chart.js `type` and dataset defaults.

```erb
<%= render LesliView::Charts::Bar.new(
    id: "tickets-chart",
    title: "Tickets",
    subtitle: "Created this week",
    labels: ["Mon", "Tue", "Wed"],
    datasets: [{ label: "Created", data: [4, 7, 3] }],
    height: "320px",
    compact: false
) %>
```

| Option | Default | Purpose |
| --- | --- | --- |
| `id:` | Generated | DOM target passed to the JavaScript chart renderer |
| `title:` | `nil` | Accessible chart heading and default single-dataset label |
| `subtitle:` | `nil` | Supporting copy |
| `labels:` | `[]` | X-axis labels |
| `dataset:` | `nil` | Shorthand for one data series |
| `datasets:` | `nil` | Array of Chart.js-compatible dataset hashes |
| `database_to_dataset:` | `nil` | Records with `xaxiskey` and `yaxiskey` fields for one series |
| `database_to_datasets:` | `nil` | Records with `dataname`, `xaxiskey`, and `yaxiskey` fields |
| `height:` | `400px` | CSS length; invalid values fall back to `400px` |
| `compact:` | `false` | Uses the compact title presentation |

If several data inputs are supplied, later conversion options take precedence over `datasets` and `dataset`. Database conversion helpers are also available as `database_to_dataset` and `database_to_datasets` for compatibility.

The rendered page requires the `window.LesliChart` JavaScript provided by the Lesli frontend assets. Rendering waits for Turbo when the document is still loading.
