require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require "nokogiri"
require_relative "../../lib/lesli_view/partials/error"
require_relative "../../lib/lesli_view/elements/empty"

class ErrorPartialTest < Minitest::Test
    def test_escapes_title_and_message_and_omits_optional_regions
        component = LesliView::Partials::Error.new(
            title: "<script>Title</script>", message: "<b>Message</b>"
        )
        document = Nokogiri::HTML.fragment(component.render_in(ActionView::Base.empty))

        assert_equal "<script>Title</script>", document.at_css("h2").text
        assert_equal "<b>Message</b>", document.at_css("p").text
        assert_nil document.at_css("script, b")
        assert_nil document.at_css(".lesli-error-details")
        assert_nil document.at_css(".lesli-error-illustration")
        assert_equal document.at_css("h2")["id"], document.at_css("section")["aria-labelledby"]
    end

    def test_renders_custom_illustration_details_and_danger_tone
        component = LesliView::Partials::Error.new(
            id: "unauthorized", title: "403 Forbidden", message: "Access denied.", tone: :danger
        )
        component.with_illustration { "shield_lock" }
        component.with_details { "Administrator" }
        document = Nokogiri::HTML.fragment(component.render_in(ActionView::Base.empty))

        assert document.at_css(".lesli-error.is-danger")
        assert document.at_css("#unauthorized-title")
        assert_equal "true", document.at_css(".lesli-error-illustration")["aria-hidden"]
        assert_equal "Administrator", document.at_css(".lesli-error-details").text
    end

    def test_reuses_empty_as_an_illustration
        component = LesliView::Partials::Error.new(title: "404", message: "Not found")
        component.with_illustration do
            LesliView::Elements::Empty.new(text: nil).render_in(ActionView::Base.empty)
        end
        document = Nokogiri::HTML.fragment(component.render_in(ActionView::Base.empty))

        assert document.at_css(".lesli-error-illustration .lesli-empty-state svg")
        assert_nil document.at_css(".lesli-empty-state-title")
        assert_nil document.at_css(".lesli-error-details")
    end

    def test_generated_title_ids_are_unique
        first = LesliView::Partials::Error.new(title: "First", message: "")
        second = LesliView::Partials::Error.new(title: "Second", message: "")

        refute_equal first.title_id, second.title_id
    end
end
