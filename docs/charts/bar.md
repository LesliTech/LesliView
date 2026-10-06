# Bar chart

`LesliView::Charts::Bar` renders a Chart.js bar chart through the shared `General` component.

```erb
<%= render LesliView::Charts::Bar.new(
    title: "Tickets by status",
    labels: ["Open", "Pending", "Closed"],
    dataset: [12, 7, 19],
    height: "20rem"
) %>
```

For multiple series, pass `datasets`:

```erb
<%= render LesliView::Charts::Bar.new(
    labels: ["Mon", "Tue", "Wed"],
    datasets: [
        { label: "Created", data: [5, 8, 4] },
        { label: "Resolved", data: [3, 6, 7] }
    ]
) %>
```

Bar charts merge each dataset with the default sky background, border color, and one-pixel border. Dataset attributes supplied by the caller override those defaults. See [General chart](/gems/view/charts/general) for all constructor options and database conversion inputs.
