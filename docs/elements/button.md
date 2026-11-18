# Button

`LesliView::Elements::Button` renders a button, a navigation link, or a Rails `button_to` form. Use this component for page actions so styling, icons and Turbo behavior remain consistent.

## Component files

Button uses ViewComponent's sidecar layout:

```text
lib/lesli_view/elements/
    button.rb
    button/
        button.html.erb
        button.css
```

The template and Ruby class render semantic classes such as `lesli-button`,
`lesli-icon`, and the existing `is-*` modifiers. Presentation belongs to the
sidecar stylesheet, imported by `source/tailwind/view.css` and compiled into the
same LesliView stylesheet. No additional stylesheet request is needed.

The stylesheet uses unprefixed Tailwind utilities inside `@apply`. Only the
component selectors are published; runtime theme values remain in LesliAssets.

## Rendering modes

| Options | Output | Use |
| --- | --- | --- |
| No `url` or `method` | `<button type="button">` | Client-side actions |
| `url:` | `<a>` | Navigation |
| `url:` and `method:` | Rails `button_to` form | Actions such as update or delete |

`method:` takes precedence over `url:` when selecting the rendering mode. Use a plain `url:` for GET navigation.

```erb
<%= render LesliView::Elements::Button.new(
    "Create ticket",
    url: new_ticket_path,
    icon: "add"
) %>
```

## Options

The optional first positional argument is the visible label. A block can provide the label instead; a nonblank positional label takes precedence.

| Option | Default | Purpose |
| --- | --- | --- |
| `url:` | `nil` | Navigation or form destination |
| `method:` | `nil` | HTTP method for `button_to` |
| `params:` | `nil` | Additional parameters for `button_to` |
| `icon:` | `nil` | Material Symbol name |
| `solid:` | `true` | Set to `false` for an outlined button |
| `light:` | `false` | Use a light background variant |
| `small:` | `false` | Use a compact button |
| `info:` | `false` | Explicit informational variant |
| `success:` | `false` | Success variant |
| `warning:` | `false` | Warning variant |
| `danger:` | `false` | Danger variant |
| `loading:` | `false` | Show a spinner, set `aria-busy` and disable activation |
| `disabled:` | `false` | Disable a button or replace a link with a non-interactive span |
| `dispatch:` | `nil` | Dispatch an Alpine event on click |
| `data:` | `{}` | HTML data attributes, merged with `turbo_frame: "_top"` |
| `css_class:` | `nil` | Additional CSS classes |
| `aria_label:` | `nil` | Accessible label, particularly for icon-only buttons |
| `type:` | `:button` | Type of a plain button; use `:submit` inside a form |
| `name:` | `nil` | Submitter name for a plain button |
| `value:` | `nil` | Submitter value for a plain button |

Buttons use the account-customizable primary color by default. Solid, light and
outlined buttons all follow this default; no extra option is required. Use
`solid: false` for secondary actions instead of changing their meaning to `info`.

Enable `info: true` only for an explicitly informational action. Variant
precedence is `warning`, `success`, `danger`, then `info`; otherwise the button
uses `primary`. Prefer selecting one semantic variant at a time. Form-builder
buttons also default to `category: "primary"`.

The component uses LesliView's button styles and Material Symbols. The host must load those assets. `loading:` is an explicit rendering state; the component does not automatically toggle it around requests.

## Choosing a color

| Variant | Use it for | Example label |
| --- | --- | --- |
| Default primary | Main actions; follows the account color | Create ticket, Save changes |
| `info: true` | An explicitly informational action | Explain this status |
| `success: true` | Acceptance or a positive state transition | Accept invitation |
| `warning: true` | An action that requires attention | Review warnings |
| `danger: true` | A destructive action | Delete event |

A normal Save button stays primary; the notification after a successful save
uses success. Secondary actions can use `solid: false` without changing their
meaning to info. There is no `primary: true` option: omit the semantic flags.

```erb
<%= render LesliView::Elements::Button.new("Save changes", type: :submit) %>
<%= render LesliView::Elements::Button.new("Explain this status", info: true) %>
<%= render LesliView::Elements::Button.new("Accept invitation", success: true) %>
<%= render LesliView::Elements::Button.new("Review warnings", warning: true) %>
<%= render LesliView::Elements::Button.new("Delete event", danger: true) %>
```

These examples demonstrate appearance. Connect each action with `url:`,
`method:` or `dispatch:` as appropriate, and translate application labels.

### Final palette

| Solid variant | Background | Text | Contrast |
| --- | --- | --- | --- |
| Default primary (700) | `#194A99` | White | 8.46:1 |
| Info | `#087EAE` (500) | White | 4.56:1 |
| Success | `#09855E` (500) | White | 4.64:1 |
| Warning | `#F0A51B` (500) | `#452B08` (900) | 6.31:1 |
| Danger | `#D73554` (500) | White | 4.64:1 |

LesliAssets supplies these tokens from `lesli-css`; do not copy hex values into
component styles. Info, success and danger hover at 600; warning hovers at 600
and retains dark text. These opaque solid and hover pairs exceed 4.5:1.
The primary ratio describes the official fallback only: check white-text contrast
when choosing a custom account color. Light, outlined and translucent variants
must be evaluated using their actual foreground and background.

## Forms and destructive actions

Use `method:` for a standalone action. Rails generates a form, including the method override and authenticity token when applicable. `params:` adds the action's submitted parameters.

```erb
<%= render LesliView::Elements::Button.new(
    "Accept invitation",
    url: event_attendant_path(@event),
    method: :patch,
    params: { attendant: { response: "accepted" } },
    success: true
) %>

<%= render LesliView::Elements::Button.new(
    "Delete event",
    url: event_path(@event),
    method: :delete,
    danger: true,
    data: { turbo_confirm: "Delete this event?" }
) %>
```

Confirmation requires Turbo. Supply translated labels and confirmation messages through `t(...)` in application views.

Inside an existing form, use `type: :submit` without `url:` or `method:`. Do not nest a `button_to` form inside another form. `name:` and `value:` identify the clicked submitter when needed.

```erb
<%= form_with model: @role do |form| %>
    <%= form.text_field :name %>
    <%= render LesliView::Elements::Button.new(
        "Save and activate",
        type: :submit,
        name: "role[active]",
        value: true
    ) %>
<% end %>
```

`type:`, `name:` and `value:` apply to the plain-button mode. For a `method:` action, send values through `params:`.

## Turbo navigation

Buttons default to `data-turbo-frame="_top"`. Links navigate the whole page even when rendered inside a Turbo Frame. This does **not** disable Turbo.

To keep navigation or a form action inside a frame, override the target explicitly:

```erb
<%= render LesliView::Elements::Button.new(
    "Edit event",
    url: edit_event_path(@event),
    icon: "edit",
    data: { turbo_frame: "event-detail" }
) %>

<%= render LesliView::Elements::Button.new(
    "Accept invitation",
    url: event_attendant_path(@event),
    method: :patch,
    params: { attendant: { response: "accepted" } },
    data: { turbo_frame: "event-detail" }
) %>
```

The destination HTML, including a redirected response, must contain the matching `turbo_frame_tag "event-detail"`. An action can alternatively return Turbo Streams to update the relevant content. The button does not define the controller's response behavior.

## Opening a panel

Combine `dispatch:` with a frame-targeted link to open the existing [Panel component](../components/panel.md) and load its content. Alpine handles the panel event; Turbo handles the request.

```erb
<%= render LesliView::Elements::Button.new(
    "View event",
    url: event_path(@event),
    dispatch: "event-panel",
    data: { turbo_frame: "event-detail" }
) %>

<%= render LesliView::Components::Panel.new("Event details", "event-panel") do %>
    <%= turbo_frame_tag "event-detail", target: "_top" %>
<% end %>
```

The event name must match the panel's second argument. `dispatch:` requires Alpine.js and does not prevent the link navigation or submit a request by itself. Without `url:` or `method:`, it simply dispatches the event from a plain button.

Within a narrow panel, place action buttons below the content in a wrapping group instead of crowding the header:

```erb
<div class="mt-4 flex flex-wrap gap-3" role="group" aria-label="Event actions">
    <%= render LesliView::Elements::Button.new(
        "Edit event",
        url: edit_event_path(@event),
        icon: "edit",
        data: { turbo_frame: "event-detail" }
    ) %>
    <%= render LesliView::Elements::Button.new(
        "Open destination",
        url: @event.url,
        solid: false
    ) if @event.url.present? %>
</div>
```

## Icon-only buttons and block labels

Provide a descriptive, translated `aria_label:` for icon-only actions. When omitted, the component uses the humanized icon name, which may not explain the action adequately. Icons themselves are hidden from assistive technology.

```erb
<%= render LesliView::Elements::Button.new(
    icon: "edit",
    aria_label: "Edit event",
    url: edit_event_path(@event),
    small: true
) %>

<%= render LesliView::Elements::Button.new(url: events_path, solid: false) do %>
    View events
<% end %>
```
