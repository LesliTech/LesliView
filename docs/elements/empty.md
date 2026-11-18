# Empty state

`LesliView::Elements::Empty` renders a consistent no-content state with optional explanation and actions.

```erb
<%= render LesliView::Elements::Empty.new(
    text: "No tickets yet",
    description: "Create the first ticket to begin tracking work."
) do %>
    <%= render LesliView::Elements::Button.new("Create ticket", url: new_ticket_path) %>
<% end %>
```

`text:` defaults to `No data found`; set it to `nil` for illustration-only contexts. `description:` and the action block are optional. Keep the text specific to the missing resource and make the block action the natural next step.

## Component files

```text
lib/lesli_view/elements/
    empty.rb
    empty/
        empty.html.erb
        empty.css
```

The Ruby API is unchanged. The sidecar stylesheet uses semantic classes and
unprefixed `@apply`, and is imported by `source/tailwind/view.css` into the
existing LesliView stylesheet. Global theme variables remain in LesliAssets.
