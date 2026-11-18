# Attachments

`LesliView::Items::Attachments` renders a multipart upload form and the files attached to a resource that includes `Lesli::Items::Attachments`.

```erb
<%= render LesliView::Items::Attachments.new(@ticket) %>
```

The component derives its attachment class, form scope, and item routes from the resource. The default form posts `file` and an optional `label` to the engine's `items_attachments_path`. Downloads and removals use the polymorphic attachment path.

`path_to_create:` and `path_to_update:` remain available when an engine needs custom routes. `path_to_update:` accepts a callable that receives each attachment.

Files are uploaded through the Rails application in this first implementation. Storage is delegated to Active Storage and therefore follows the service selected by the host application.

## Component files

```text
lib/lesli_view/items/
    attachments.rb
    attachments/
        attachments.html.erb
        attachments.css
    attachment.rb
    attachment/
        attachment.html.erb
        attachment.css
```

Ruby classes retain their public API. Each template and stylesheet lives in
the adjacent component directory. The stylesheets use semantic classes and
unprefixed `@apply`, and are imported by `source/tailwind/view.css` into the
existing LesliView stylesheet. Global theme variables remain in LesliAssets.
