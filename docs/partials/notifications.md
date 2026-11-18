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

## Choosing a category

| Category | Example |
| --- | --- |
| `info` | Your Lesli application is ready. |
| `success` | Your data import completed successfully. |
| `warning` | Scheduled maintenance starts in one hour. |
| `danger` | The import failed. Review the errors before trying again. |

Primary belongs to actions and selection, not message categories. Use one of the
four categories above for status messages. See [Button](../elements/button.md#choosing-a-color)
for action colors and the final solid palette.

The final theme uses sky, emerald, amber and rose inspired semantic tones.
Backgrounds use shade `50`, borders `300`, and text `900`; these opaque text
pairs have contrasts of 9.76:1 (info), 9.77:1 (success), 12.65:1 (warning) and
8.92:1 (danger). LesliAssets supplies the global tokens from `lesli-css`;
LesliView compiles the component classes. Account primary changes do not alter
these status meanings or colors.
