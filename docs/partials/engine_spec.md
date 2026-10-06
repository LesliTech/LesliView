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
