# Application container

`LesliView::Layout::Container` wraps page content in a named Turbo frame and the standard responsive application width.

```erb
<%= render LesliView::Layout::Container.new("tickets") do %>
    <%= render LesliView::Components::Header.new("Tickets") %>
    <%= render "table" %>
<% end %>
```

The Turbo frame ID is required and must be unique on the page. The default layout uses a maximum width of `7xl`; pass `dashboard: true` to use the dashboard container class instead.

Links or forms that must replace the entire page should target `_top`. LesliView actions such as the shared Button and Header back action already apply that target where appropriate.

## Component files

```text
lib/lesli_view/layout/
    container.rb
    container/
        container.html.erb
        container.css
```

The Ruby API stays unchanged. The sidecar stylesheet uses semantic component
classes and unprefixed `@apply`; it is imported by `source/tailwind/view.css`.
LesliAssets supplies the shared theme, and LesliView compiles its own stylesheet.
