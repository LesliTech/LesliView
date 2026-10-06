# Table

`LesliView::Elements::Table` renders either a record collection or rows composed through slots.

```erb
<%= render LesliView::Elements::Table.new(
    columns: [
        { field: :id, label: "ID", width: 80 },
        { field: :subject, label: "Subject" },
        { field: :status, label: "Status", align: :right }
    ],
    records: @tickets,
    caption: "Support tickets",
    link: ->(ticket) { ticket_path(ticket) }
) %>
```

Records can be Active Record objects or hashes with string or symbol keys. Column hashes require `field` and normally include `label`; `align:` accepts `left`, `center`, or `right`.

For custom cell content, use row and cell slots:

```erb
<%= render LesliView::Elements::Table.new(columns: columns) do |table| %>
    <% table.with_row(status: :success) do |row| %>
        <% row.with_cell { "#42" } %>
        <% row.with_cell { tag.strong("Resolved") } %>
    <% end %>
<% end %>
```

`headless:`, `striped:`, `compact:`, `id:`, and `class_name:` control presentation. `empty:` customizes the empty message. Row status accepts `danger`, `info`, `success`, or `warning`. Add `caption:` whenever surrounding text does not already identify the table.
