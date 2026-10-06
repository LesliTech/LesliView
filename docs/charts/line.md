# Line chart

`LesliView::Charts::Line` renders a Chart.js line chart through the shared `General` component.

```erb
<%= render LesliView::Charts::Line.new(
    title: "Weekly activity",
    subtitle: "Created records",
    labels: ["Mon", "Tue", "Wed", "Thu", "Fri"],
    dataset: [4, 1, 4, 2, 5]
) %>
```

Multiple datasets use Chart.js-compatible hashes:

```erb
<%= render LesliView::Charts::Line.new(
    labels: ["Mon", "Tue", "Wed"],
    datasets: [
        { label: "Last week", data: [4, 1, 4] },
        { label: "This week", data: [3, 2, 5] }
    ]
) %>
```

Line charts add a filled translucent background, sky border, and point styles by default. Caller-supplied dataset attributes override those values. See [General chart](/gems/view/charts/general) for the complete input contract.
