# Discussions

LesliView provides a collection component and a single-message component for resource discussions:

```erb
<%= render LesliView::Items::Discussions.new(@ticket) %>
```

`Discussions` expects the resource to include the Lesli discussions concern. The component reads `lesli_discussions_class` and `lesli_discussions_association_name` from the resource class, so custom models and association names are respected. It derives the form scope from the configured model and posts through the polymorphic `items_discussions_path` route with `discussable_type` and `discussable_id`. The form uses a plain textarea provided by the LesliView builder.

The collection is a linear list of comments. A discussion record does not
represent a thread and does not support replies or parent comments.

Each record is rendered with:

```erb
<%= render LesliView::Items::Discussion.new(discussion) %>
```

The single-message template reads the author from the discussion association and
formats the record's `created_at` timestamp. Messages are rendered as escaped
plain text, and CSS preserves their line breaks. HTML submitted by an API client
is displayed as text rather than interpreted as markup.

After a successful Turbo submission, the collection is replaced with a fresh
component so the form is cleared and the new comment is shown in the configured
association order. An invalid submission replaces the component with the invalid
record, preserving the submitted message and displaying its validation errors.

These components are domain-coupled and are intended for Lesli engines that implement the standard discussion concern and routes.
