# Discussions

LesliView provides a collection component and a single-message component for resource discussions:

```erb
<%= render LesliView::Items::Discussions.new(@ticket) %>
```

`Discussions` expects the resource to expose `id`, `discussions`, and a namespaced `Items::Discussion` model. It derives the form scope from that model and posts through the polymorphic `items_discussions_path` route with `discussable_type` and `discussable_id`. The form uses a plain textarea provided by the LesliView builder.

The collection is a linear list of comments. A discussion record does not
represent a thread and does not support replies or parent comments.

Each record is rendered with:

```erb
<%= render LesliView::Items::Discussion.new(discussion) %>
```

The single-message template expects a discussion with `message` and an optional
`created_at_string`. Messages are rendered as escaped plain text, and CSS
preserves their line breaks. HTML submitted by an API client is displayed as
text rather than interpreted as markup.

These components are domain-coupled and are intended for Lesli engines that implement the standard discussion associations, models, and routes. The optional path argument on `Discussions` is retained but the current template derives its create route polymorphically.
