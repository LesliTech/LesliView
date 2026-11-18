# Navigation sidebar

This is the standard layout for page-level navigation sidebars in Lesli
engines. Use it for modules, settings sections, and role or permission editors.
It does not replace the application's global navigation or a slide-over editor.

## Layout contract

- Place the LesliView Header above the sidebar/content row. Page actions use
  `LesliView::Elements::Button` and belong in that header; submit controls may
  remain inside their form.
- At the `lg` breakpoint, show a 240 px sidebar (`w-60`) that does not shrink.
  Use `sticky top-4`, not fixed positioning, so it stays in the page flow.
- Give the content `min-w-0 flex-1` so it uses the remaining available width.
  Keep searches and content-specific toolbars inside this content column.
- Below `lg`, stack navigation above content and present it as a native
  `details`/`summary` disclosure. Show the selected item's label when closed.
- Limit the expanded mobile navigation to `max-h-72 overflow-y-auto`.
- Render desktop and mobile links from the same items. Only one navigation
  presentation is visible at a time; never duplicate DOM IDs between them.

## Navigation and accessibility

Use real Rails links, translated labels, a descriptive `aria-label` for each
`nav`, and `aria-current="page"` on the selected link. Retain visible keyboard
focus and a minimum 44 px target (`min-h-11`). Decorative icons are hidden from
assistive technology. Native disclosure and links need no custom JavaScript.

Selection comes from the current route or server state. Preserve relevant
search and filter parameters when building links. Page navigation targets
`data-turbo-frame="_top"`; partial Turbo responses must preserve the selection
and the complete module list. Hiding a link is not authorization: controllers
must still enforce account boundaries and privileges.

## Usage

Build navigation data in the owning engine. Each item contains `label`, `path`,
`selected`, and optionally `count` and `icon`. Keep URL generation and domain queries out
of the shared presentation partial. Use `LesliView::Layout::NavigationSidebar.new(items:, label:)`.
The optional `empty_selection_label:` is shown on mobile when no item is selected;
it defaults to `label`. Labels are translated by the caller. A count of zero
is displayed; omit `count` to hide the badge.

Set `icon` to a Remix Icon CSS class, such as `"ri-calendar-event-line"`.
Items without an icon retain `"ri-folder-line"`. The mobile disclosure also
shows the selected item's icon. The host must load the Remix Icon stylesheet.

```erb
<%= render LesliView::Layout::Container.new("settings") do %>
    <%= render LesliView::Components::Header.new(t("settings.title")) %>

    <div class="flex min-w-0 flex-col gap-6 lg:flex-row lg:items-start">
        <%= render LesliView::Layout::NavigationSidebar.new(
            items: @navigation_items,
            label: t("settings.navigation")
        ) %>

        <div class="min-w-0 flex-1 space-y-6">
            <%= render "form" %>
        </div>
    </div>
<% end %>
```

## Custom icons per option

Provide an `icon:` key in each item hash. Use the complete Remix Icon CSS class,
such as `"ri-mail-unread-line"`, rather than a Material Symbol name or HTML markup.
The same item definition supplies both desktop and mobile navigation.

For example, an engine can define Agenda's options in its view or helper:

```erb
<%
navigation_items = [
    {
        label: t("lesli_calendar.agendas.upcoming"),
        path: agenda_path(view: "upcoming"),
        selected: @agenda_view == "upcoming",
        icon: "ri-calendar-todo-line"
    },
    {
        label: t("lesli_calendar.agendas.mine"),
        path: agenda_path(view: "mine"),
        selected: @agenda_view == "mine",
        icon: "ri-calendar-event-line"
    },
    {
        label: t("lesli_calendar.agendas.pending"),
        path: agenda_path(view: "pending"),
        selected: @agenda_view == "pending",
        icon: "ri-mail-unread-line"
    },
    {
        label: t("lesli_calendar.agendas.available"),
        path: agenda_path(view: "available"),
        selected: @agenda_view == "available",
        icon: "ri-global-line"
    }
]
%>

<%= render LesliView::Layout::NavigationSidebar.new(
    items: navigation_items,
    label: t("lesli_calendar.agendas.views")
) %>
```

The route helpers, translations and selected state belong to the calling engine.
No changes to the shared component are required to choose different icons.

### Default icon and mobile selection

Omit `icon:` or pass `nil` to use `"ri-folder-line"`. For example, this item keeps
the default folder icon while displaying a count:

```ruby
{
    label: "All modules",
    path: "/modules",
    selected: true,
    count: 0
}
```

Do not use an empty string to request the default: the component falls back only
when the icon is omitted or `nil`.

On mobile, the closed disclosure shows the selected item's label and icon.
If no item is selected, it uses the folder icon and `empty_selection_label:`
(or the navigation `label`). Mark at most one item as selected; if several are
selected, the disclosure uses the first one.

Icons are decorative (`aria-hidden="true"`), so each option still needs a clear
text label. The host must load the Remix Icon font and stylesheet containing the
chosen classes; the component does not load or validate icon assets.

## Component implementation

The Ruby class remains in `layout/navigation_sidebar.rb`. Its template and CSS
are grouped in the adjacent `layout/navigation_sidebar/` directory. The CSS uses
semantic component classes and unprefixed `@apply`, and is imported by the shared
LesliView stylesheet. Runtime theme variables remain in LesliAssets.

The shared markup lives in `lib/lesli_view/layout/navigation_sidebar/navigation_sidebar.html.erb`.
Do not copy it into engines. Their partials should only build navigation items
and render the component. No domain queries or routes belong in the component.

## Existing implementations

- Babel: `app/views/lesli_babel/labels/_module_navigation.html.erb` and
  `labels/index.html.erb`.
- Calendar: `app/views/lesli_calendar/agendas/show.html.erb`, with an icon per Agenda view.
- Shield: `app/views/lesli_shield/roles/show.html.erb`,
  and `role/actions/_permissions.html.erb`.

Check both desktop and narrow mobile layouts when changing this pattern.
Verify keyboard navigation, the selected item, long labels, URL parameters,
and Turbo updates. Rendering tests must account for both responsive navigation
copies while ensuring that only the appropriate one is displayed.
