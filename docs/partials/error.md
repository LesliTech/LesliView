# Error

`LesliView::Partials::Error` presents an error title, message, optional
decorative illustration and additional details. It does not set an HTTP status,
authorize requests or inspect error objects.

```erb
<%= render LesliView::Partials::Error.new(
    id: "not-found",
    title: t("errors.not_found.title"),
    message: t("errors.not_found.message")
) do |error| %>
    <% error.with_illustration do %>
        <%= render LesliView::Elements::Empty.new(text: nil) %>
    <% end %>
<% end %>
```

Pass translated text through required `title:` and `message:` keywords.
Both are escaped. The optional `id:` supplies the prefix for the heading ID
and its `aria-labelledby` reference; otherwise a unique prefix is generated.
Use distinct IDs when rendering multiple instances on a page.

Use `tone: :danger` for the danger-colored heading and icon:

```erb
<%= render LesliView::Partials::Error.new(
    title: "403 Forbidden",
    message: "Contact your administrator.",
    tone: :danger
) do |error| %>
    <% error.with_illustration do %>
        <span class="material-symbols lesli-error-icon">shield_lock</span>
    <% end %>
    <% error.with_details do %>
        <ul>
            <li><%= controller_name %></li>
            <li><%= action_name %></li>
        </ul>
    <% end %>
<% end %>
```

The illustration region is decorative and has `aria-hidden="true"`; keep
essential information and interactive controls outside it. The optional details
slot renders inside a styled panel. Omitted slots produce no empty wrappers.
The caller is responsible for escaping any dynamic values in its slot markup.

The component does not add a Turbo frame. Wrap it in `Layout::Container` when
needed. Core preserves its existing 403/404 templates, status handling and
authorization logic; Welcome is not part of this component.

Files follow the shared sidecar convention:

```text
partials/
    error.rb
    error/
        error.html.erb
        error.css
```

Styles compile in LesliView and reference the shared LesliAssets theme.
