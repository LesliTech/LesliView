# Activities

`LesliView::Items::Activities` loads a resource's recent activities and renders them through the shared timeline. It eager-loads each actor, orders the collection newest first, and limits the initial query to 25 records.

```erb
<%= render LesliView::Items::Activities.new(
    @ticket,
    i18n_scope: "my_engine.items.activities",
    icons: {
        ticket_created: "add_circle",
        owner_changed: "manage_accounts"
    }
) %>
```

The resource must expose an Active Record `activities` association. Each activity must provide `actor`, `activity_code`, `activity_type`, `created_at`, `description`, and `metadata`.

The component converts every record to the timeline contract:

- `operation` is the short event title.
- `description` explains what changed.
- `actor` identifies the user who performed the action.
- `date` contains the localized event time.
- `icon` contains the event code that `icons:` maps to a Material Symbol.

Use `i18n_scope:` to keep each engine's event messages independent, and
optionally map event codes to Material Symbols with `icons:`. Relation events
may define `set`, `changed`, and `removed` descriptions; the component selects
the correct variant from the activity's `from` and `to` metadata. When omitted,
the scope defaults to `lesli.items.activities` for shared messages.

```yaml
en:
  my_engine:
    items:
      activities:
        events:
          owner_changed:
            operation: Owner changed
            set: Assigned to %{to}.
            changed: Changed from %{from} to %{to}.
            removed: Removed %{from} as owner.
```

Override the initial query size with `limit:` when needed. It must be a positive integer:

```erb
<%= render LesliView::Items::Activities.new(
    @ticket,
    i18n_scope: "my_engine.items.activities",
    icons: { ticket_created: "add_circle" },
    limit: 50
) %>
```

This component is intended for Lesli records using the standard activity schema. For already prepared hashes, render [Timeline](/gems/view/components/timeline) directly.
