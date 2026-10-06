# Discussions

LesliView provides a collection component and a single-message component for resource discussions:

```erb
<%= render LesliView::Items::Discussions.new(@ticket) %>
```

`Discussions` expects the resource to expose `id`, `discussions`, and a namespaced `Items::Discussion` model. It derives the form scope from that model and posts through the polymorphic `items_discussions_path` route with `discussable_type` and `discussable_id`. The form uses the LesliView builder and Lexxy rich-text field.

Each record is rendered with:

```erb
<%= render LesliView::Items::Discussion.new(discussion) %>
```

The current single-message template expects a discussion with `message` and an optional `created_at_string`. It renders the message as trusted rich HTML. Only pass content that has been sanitized by the application's rich-text pipeline.

These components are domain-coupled and are intended for Lesli engines that implement the standard discussion associations, models, and routes. The optional path argument on `Discussions` is retained but the current template derives its create route polymorphically.
