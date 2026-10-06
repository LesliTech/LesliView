# Tabs

`LesliView::Components::Tabs` renders client-side tabs with Alpine.js. The component requires Alpine to be loaded by the host assets.

```erb
<%= render LesliView::Components::Tabs.new(active_tab: "details") do |tabs| %>
    <% tabs.with_tab(id: "details", title: "Details") do %>
        <p>Ticket details</p>
    <% end %>

    <% tabs.with_tab(id: "activity", title: "Activity", icon: "history") do %>
        <p>Recent changes</p>
    <% end %>
<% end %>
```

`active_tab:` selects the initial tab; otherwise the first tab is used. Set `vertical: true` for the vertical presentation. Each `with_tab` accepts `id:`, `title:`, and an optional Material Symbol `icon:`. When `id:` is omitted, a normalized ID is generated from the title and falls back to the tab position.
