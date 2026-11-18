# Toolbar

`LesliView::Components::Toolbar` provides a GET search form with optional filter and action slots.

```erb
<%= render LesliView::Components::Toolbar.new(
    "Search tickets...",
    url: tickets_path,
    search_name: :query
) do |toolbar| %>
    <% toolbar.with_filters do %>
        <%= select_tag :status, options_for_select(statuses, params[:status]) %>
    <% end %>
    <% toolbar.with_actions do %>
        <%= render LesliView::Elements::Button.new("New", url: new_ticket_path) %>
    <% end %>
<% end %>
```

The positional argument sets the placeholder. `initial_value:` overrides the current query value, `url:` defaults to the request path, and `search_name:` defaults to `:search`. Clearing a search preserves the other query parameters.

## Component files

```text
lib/lesli_view/components/
    toolbar.rb
    toolbar/
        toolbar.html.erb
        toolbar.css
```

The Ruby API is unchanged. The sidecar stylesheet uses semantic classes and
unprefixed `@apply`, and is imported by `source/tailwind/view.css` into the
existing LesliView stylesheet. Global theme variables remain in LesliAssets.
