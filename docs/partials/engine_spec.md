# Engine specification

`LesliView::Partials::EngineSpec` renders compact metadata for an installed Lesli engine.

```erb
<%= render LesliView::Partials::EngineSpec.new(
    name: "LesliSupport",
    summary: "Customer support workflows",
    version: "1.4.0",
    build: "1791168000",
    metadata: {
        "documentation_uri" => "https://www.lesli.dev/engines/support/"
    }
) %>
```

The engine value must support symbol access for `name`, `summary`, `version`, `build`, and `metadata`, plus `dig` for the documentation URL. `build` is interpreted as a Unix timestamp and formatted with LesliDate. The documentation entry becomes an external link when `metadata["documentation_uri"]` is present.

This partial uses the legacy engine-status presentation and assumes LesliDate and the shared icon styles are loaded.

## Component files

```text
lib/lesli_view/partials/
    engine_spec.rb
    engine_spec/
        engine_spec.html.erb
        engine_spec.css
```

The Ruby class keeps the same public API. Its template and stylesheet live in
the adjacent component directory. The stylesheet uses semantic classes and
unprefixed Tailwind utilities inside `@apply`; `source/tailwind/view.css` imports
it into the existing LesliView stylesheet. Global theme variables remain in
LesliAssets.
