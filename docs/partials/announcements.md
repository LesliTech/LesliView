# Announcements

`LesliView::Partials::Announcements` displays persistent banners from plain hashes.
It does not query LesliBell or determine audience membership.

```erb
<%= render LesliView::Partials::Announcements.new(
    announcements: [{
        id: 7,
        category: "info",
        category_label: "Information",
        message: "Your application is ready.",
        url: "/help",
        dismiss_url: "/bell/announcements/7/dismiss"
    }],
    label: "Announcements",
    link_label: "Learn more",
    dismiss_label: "Dismiss announcement"
) %>
```

Translate labels in the caller. Categories are `info`, `success`, `warning` and
`danger`; unknown categories use the information presentation. Messages are
escaped and preserve line breaks. Empty collections render nothing.

`url` and `dismiss_url` are optional. A dismissal URL renders a POST button;
omit it for announcements that cannot be closed. The caller must authorize
dismissal on the server. The banner stays visible until the response removes it.

The component preserves `application-lesli-announcements`, `announcement-<id>`
and `announcement-<id>-message`. Core supplies authorized records, translated
labels and routes; LesliBell removes the announcement ID through Turbo after
successful dismissal.

The template and CSS live in `partials/announcements/`, next to
`announcements.rb`. Styles compile into LesliView using the global LesliAssets
theme. Announcements never disappear automatically.

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
