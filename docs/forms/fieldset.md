# Fieldset

`fieldset` groups related controls with a semantic HTML fieldset and optional legend.

```erb
<%= form.fieldset("Contact details", category: :info) do %>
    <%= form.field_control_text :name %>
    <%= form.field_control_email :email %>
<% end %>
```

The second argument is an HTML options hash. Existing classes are merged with `lesli-form-fieldset`; `category:` adds the corresponding semantic `is-*` class. An empty legend is omitted.
