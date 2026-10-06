# Activities

`LesliView::Items::Activities` queries a resource's activity association and renders the result through the shared timeline.

```erb
<%= render LesliView::Items::Activities.new(
    @ticket,
    icons: { create: "add_circle", update: "edit" }
) %>
```

The resource must expose an Active Record `activities` association with `id`, `description`, `activity_code`, and `created_at`. The component selects the description as the timeline operation, maps the activity code to an icon, formats creation time through the framework date helper, orders newest first, and converts the result to hashes.

This component is intended for Lesli records using the standard activity schema. For already prepared hashes, render [Timeline](/gems/view/components/timeline) directly.
