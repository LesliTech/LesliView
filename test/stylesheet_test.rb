require "minitest/autorun"

class StylesheetTest < Minitest::Test
    def test_compiled_styles_use_the_global_theme_without_prefixed_copies
        css = File.read(File.expand_path("../app/assets/stylesheets/lesli_view/view.css", __dir__))

        # Component rules use LesliAssets tokens without redefining the global theme.
        refute_includes css, "var(--lesliview-"
        refute_match(/--(?:lesliview-|color-|text-|spacing|lesli-)[\w-]*\s*:/, css)
        assert_includes css, ".lesli-panel-dialog"
        refute_includes css, ".lesliview"
        refute_match(/\.(?:flex|grid|hidden|text-sm)\s*\{/, css)
        refute_match(/\.flex-col\s*\{/, css)
        assert_includes css, ".lesli-timeline-entry:last-child .lesli-timeline-connector"
        assert_includes css, ".lesli-navigation-sidebar-mobile[open] .lesli-navigation-sidebar-chevron"
        assert_includes css, "@media (width >= 40rem)"
        assert_includes css, "max-width: var(--container-2xl)"
    end
end
