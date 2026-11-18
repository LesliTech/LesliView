# Panel

`LesliView::Components::Panel` renders an Alpine-powered panel that slides in from the right. Use it to display details or forms while keeping the underlying page in place.

## Options and behavior

| Argument | Default | Purpose |
| --- | --- | --- |
| First positional argument | Required | Visible panel title |
| Second positional argument | `"panel"` | Panel identifier and Alpine event name |
| `overlay:` | `true` | Show a background overlay that closes the panel when clicked |

The host must load Alpine.js, LesliView's panel styles and the `x-cloak` styling. Loading remote content through a Turbo Frame also requires Turbo.

The panel occupies the available width on small screens and has a constrained width on larger screens. Its content scrolls vertically, while its title and close button remain at the top.

Opening the panel focuses its close button. The close button, Escape key and optional overlay dismiss it and restore focus to the opening control. The dialog is labelled by its title and uses `aria-modal` according to `overlay:`. The component does not implement a focus trap.

Use distinct panel identifiers when rendering several panels on one page. The outer element uses `<identifier>-panel` as its DOM ID; the identifier itself is the event name.

## Render existing content

Use the [Button component](../elements/button.md) to dispatch the panel's opening event:

```erb
<%= render LesliView::Elements::Button.new(
    "Open filters",
    icon: "filter_list",
    dispatch: "ticket-filters"
) %>

<%= render LesliView::Components::Panel.new("Filters", "ticket-filters") do %>
    <%= render "filters" %>
<% end %>
```

Set `overlay: false` when the background should remain available without a dismissible overlay. Supply translated titles and button labels with `t(...)` in application views.

## Load details with Turbo

Place an empty Turbo Frame inside the panel, then target it from the opening link. The link dispatches the Alpine event to open the panel and Turbo requests the detail page.

For example, in an event list:

```erb
<% @events.each do |event| %>
    <%= render LesliView::Elements::Button.new(
        event.title,
        url: event_path(event),
        dispatch: "event-panel",
        data: { turbo_frame: "event-detail" },
        solid: false
    ) %>
<% end %>

<%= render LesliView::Components::Panel.new("Event details", "event-panel") do %>
    <%= turbo_frame_tag "event-detail", target: "_top" %>
<% end %>
```

Render one shared panel outside the list, rather than one panel per record. The panel event name (`event-panel`) and frame ID (`event-detail`) serve different purposes and need not match.

The destination view must include the matching frame. Turbo extracts that frame's content; direct navigation can still display the complete page. Load the record through the application's authorized account scope as usual: opening a panel does not bypass controller authorization.

## Place actions below the detail

Keep the panel header for its title and close control. Render record actions below the detail in a wrapping group so they fit narrow panels. For example, in `events/show.html.erb`:

```erb
<%= turbo_frame_tag "event-detail" do %>
    <h2 class="text-lg font-semibold"><%= @event.title %></h2>
    <%= render "detail", event: @event %>

    <div class="mt-4 flex flex-wrap gap-3" role="group" aria-label="Event actions">
        <%= render LesliView::Elements::Button.new(
            "Edit event",
            url: edit_event_path(@event),
            icon: "edit",
            data: { turbo_frame: turbo_frame_request_id || "_top" }
        ) %>
        <%= render LesliView::Elements::Button.new(
            "Cancel event",
            url: cancel_event_path(@event),
            method: :patch,
            warning: true,
            data: {
                turbo_frame: turbo_frame_request_id || "_top",
                turbo_confirm: "Cancel this event?"
            }
        ) %>
        <% if @event.url.present? %>
            <%= render LesliView::Elements::Button.new(
                "Open destination",
                url: @event.url,
                solid: false
            ) %>
        <% end %>
    </div>
<% end %>
```

Show editing and cancellation controls only when the current user is allowed to use them. The routes and record attributes above are application examples, not features supplied by Panel.

LesliView buttons default to `data-turbo-frame="_top"`. The explicit frame target keeps editing and cancellation inside the panel; `turbo_frame_request_id || "_top"` preserves normal page navigation when the same view is opened directly. The destination button intentionally keeps the default full-page navigation.

## Edit and submit inside the panel

The edit view must return the same frame ID, and its form must target that frame:

```erb
<%= turbo_frame_tag "event-detail" do %>
    <%= form_with model: @event,
        data: { turbo_frame: turbo_frame_request_id || "_top" } do |form| %>
        <% if @event.errors.any? %>
            <p role="alert"><%= @event.errors.full_messages.to_sentence %></p>
        <% end %>
        <%= form.label :title %>
        <%= form.text_field :title %>

        <div class="mt-4 flex flex-wrap gap-3">
            <%= render LesliView::Elements::Button.new(
                "Save event",
                type: :submit,
                data: { turbo_frame: turbo_frame_request_id || "_top" }
            ) %>
        </div>
    <% end %>
<% end %>
```

On success, redirect to a detail response containing the same frame, or return Turbo Streams for the affected content. On validation failure, render the submitted form with its errors and an HTTP 422 status; a Turbo Stream response can instead replace the form's container. Ensure the controller supports the requested format.

Use `type: :submit` inside an existing form and override the button’s default `_top` target when submitting within the panel. A button with `method:` creates its own Rails form and belongs outside another form.

Panel only controls visibility. It does not fetch data itself, clear previous content, handle request errors, close automatically after saving, or refresh the underlying list or calendar. Implement those behaviors in the owning page when needed. For example, Calendar refetches its entries after a successful Turbo submission while retaining the visible period.

## Component files

```text
lib/lesli_view/components/
    panel.rb
    panel/
        panel.html.erb
        panel.css
```

The Ruby API is unchanged. The sidecar stylesheet uses semantic classes and
unprefixed `@apply`, and is imported by `source/tailwind/view.css` into the
existing LesliView stylesheet. Global theme variables remain in LesliAssets.
