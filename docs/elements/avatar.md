# Avatar

`LesliView::Elements::Avatar` renders an image or initials derived from a name.

```erb
<%= render LesliView::Elements::Avatar.new(name: "Ada Lovelace", size: "small") %>
<%= render LesliView::Elements::Avatar.new(image: user.avatar_url, name: user.name) %>
```

`size:` accepts `small`, `medium`, or `large` and defaults to `medium`. Any other size raises `ArgumentError`. Without an image, the first letters of the first two words are displayed. The current image alternative text is generic, so nearby content should identify the represented person when that context matters.
