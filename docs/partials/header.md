# Application header

`LesliView::Partials::Header` renders global branding, actions and optional module
navigation. Use `Components::Header` for the heading inside an individual page.

```erb
<%= render LesliView::Partials::Header.new(
    home_url: root_path,
    home_label: "Home",
    actions_label: "Application actions",
    navigation_label: "Module navigation",
    actions: [{
        url: settings_path,
        label: "Settings",
        icon: "ri-settings-line",
        active: current_page?(settings_path),
        data: { turbo_frame: "_top" }
    }]
) do |header| %>
    <% header.with_logo do %>
        <%= image_tag "logo.svg", alt: "Application" %>
    <% end %>
    <% header.with_navigation do %>
        <li><%= link_to "Settings", settings_path %></li>
    <% end %>
<% end %>
```

The caller resolves routes, translates labels and selects available actions.
Each action requires `url`, `label` and an icon CSS class. Optional keys are
`active`, `danger`, `highlighted`, `count` and Rails link `data`.
Positive counts show a badge capped at `99+`. Active links have
`aria-current="page"`; danger actions use destructive-action hover colors.

The logo link targets `_top`. Action data is passed through unchanged; the
component does not invent logout methods or navigation behavior.
The optional navigation slot receives list items and preserves caller markup.

Core retains logo customization, notification counts, current-route detection,
optional-engine checks, logout URLs and custom navigation partial lookup.
The component does not access Core helpers, accounts, sessions or engine services.

The template and CSS live in `partials/header/`, next to `header.rb`.
They compile into LesliView with theme values supplied by LesliAssets.
