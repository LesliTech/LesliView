# Notifications

`LesliView::Partials::Notifications` renders transient status messages.

```erb
<%= render LesliView::Partials::Notifications.new(
    messages: { success: "Changes saved.", warning: "Review the remaining fields." }
) %>
```

Pass a hash of message types and translated text. Content is escaped.
`notice` uses success styling; `alert` and `error` use danger styling.
Unknown types use neutral styling.

The `application-lesli-notifications` region always renders, including when
messages are empty, so Turbo can replace it. The region uses
`aria-live="polite"`. Messages retain the five-second fade-out animation.

The component does not read or discard Rails flash. Core renders it with
`flash.to_hash`, then calls `flash.discard`. Existing responder methods continue
rendering Core's notification partial and replacing the same Turbo target.

The template, stylesheet and animation belong to `partials/notifications/`.
They compile into LesliView; LesliAssets supplies only shared theme values.
