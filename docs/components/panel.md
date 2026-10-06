# Panel

`LesliView::Components::Panel` renders an Alpine-powered slide-out panel with optional background overlay.

```erb
<%= render LesliView::Components::Panel.new("Filters", "ticket-filters") do %>
    <%= render "filters" %>
<% end %>

<button x-data @click="$dispatch('ticket-filters')">Open filters</button>
```

The first argument is the title. The second is the Alpine window-event name and defaults to `panel`. Set `overlay: false` to omit the dismissible page overlay. The host application must load Alpine.js and the Lesli panel styles.
