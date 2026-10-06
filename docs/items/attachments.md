# Attachments

`LesliView::Items::Attachments` is currently a presentation prototype, not a complete upload component. It renders a file input and example Word, spreadsheet, and PDF entries, but it does not submit the selected file or read attachments from the supplied resource.

```erb
<%= render LesliView::Items::Attachments.new(@ticket) %>
```

The initializer retains `path_to_create:` and `path_to_update:` compatibility arguments, but the current template does not use them. Do not rely on this component for production uploads until it is connected to a form, persisted attachments, validation, and accessible file status. Use the host application's Active Storage flow in the meantime.
