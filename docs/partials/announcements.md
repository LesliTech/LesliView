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
