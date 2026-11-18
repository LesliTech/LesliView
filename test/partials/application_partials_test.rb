require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require "nokogiri"
require_relative "../../lib/lesli_view/partials/announcements"
require_relative "../../lib/lesli_view/partials/header"
require_relative "../../lib/lesli_view/partials/notifications"

class ApplicationPartialsTest < Minitest::Test
    def test_announcements_preserve_turbo_ids_and_escape_content
        html = announcements([announcement]).render_in(view_context)
        document = Nokogiri::HTML.fragment(html)

        assert document.at_css("#application-lesli-announcements")
        assert_equal "Unsafe <script>alert(1)</script>\nSecond line",
            document.at_css("#announcement-7-message").text
        assert_nil document.at_css("script")
        assert_equal "/bell/announcements/7/dismiss", document.at_css("form")["action"]
        assert_equal "post", document.at_css("form")["method"]
        assert_equal "announcement-7-message", document.at_css("button")["aria-describedby"]
        assert_equal "_top", document.at_css("a")["data-turbo-frame"]
        assert document.at_css("#announcement-7.is-warning")
    end

    def test_non_closable_announcements_have_no_form_and_unknown_categories_fall_back
        entry = announcement.merge(dismiss_url: nil, category: "unknown", url: nil)
        document = Nokogiri::HTML.fragment(announcements([entry]).render_in(view_context))

        assert document.at_css("#announcement-7.is-info")
        assert_nil document.at_css("form")
        assert_nil document.at_css("a")
    end

    def test_no_announcements_renders_nothing
        assert_empty announcements([]).render_in(view_context)
    end

    def test_notifications_keep_an_empty_turbo_target
        html = LesliView::Partials::Notifications.new(messages: {}).render_in(view_context)
        document = Nokogiri::HTML.fragment(html)

        assert_equal "polite", document.at_css("#application-lesli-notifications")["aria-live"]
        assert_empty document.css(".lesli-notifications-message")
    end

    def test_notifications_map_flash_types_without_mutating_messages
        messages = { "notice" => "Saved", "alert" => "<script>bad</script>", "custom" => "Other" }.freeze
        html = LesliView::Partials::Notifications.new(messages: messages).render_in(view_context)
        document = Nokogiri::HTML.fragment(html)

        assert_equal "Saved", document.at_css(".is-success").text.strip
        assert_equal "<script>bad</script>", document.at_css(".is-danger").text.strip
        assert document.at_css(".is-neutral")
        assert_nil document.at_css("script")
        assert_equal 3, messages.size
    end

    def test_header_uses_supplied_routes_slots_and_link_options
        header = LesliView::Partials::Header.new(
            home_url: "/home", home_label: "Home", actions_label: "Actions",
            navigation_label: "Modules",
            actions: [
                { url: "/notifications", label: "Unread", icon: "ri-notification-3-fill",
                  active: true, highlighted: true, count: 123, data: { turbo_frame: "_top" } },
                { url: "/logout", label: "Logout", icon: "ri-logout-circle-r-line", danger: true }
            ]
        )
        header.with_logo { "Logo" }
        header.with_navigation { "Module links" }
        document = Nokogiri::HTML.fragment(header.render_in(view_context))

        assert_equal "/home", document.at_css(".lesli-application-header-logo-link")["href"]
        assert_equal "99+", document.at_css(".lesli-application-header-count").text.strip
        assert_equal "page", document.at_css('a[href="/notifications"]')["aria-current"]
        assert_equal "_top", document.at_css('a[href="/notifications"]')["data-turbo-frame"]
        assert_nil document.at_css('a[href="/logout"]')["data-turbo-frame"]
        assert_equal "Module links", document.at_css(".lesli-application-header-links").text
        assert_equal "Logo", document.at_css(".lesli-application-header-logo").text
    end

    def test_header_without_navigation_or_optional_actions
        header = LesliView::Partials::Header.new(
            home_url: "/", home_label: "Home", actions: [],
            actions_label: "Actions", navigation_label: "Modules"
        )
        document = Nokogiri::HTML.fragment(header.render_in(view_context))

        assert_nil document.at_css(".lesli-application-header-navigation")
        assert_empty document.css(".lesli-application-header-action")
    end

    private

    def view_context
        ActionView::Base.empty.tap do |view|
            view.define_singleton_method(:protect_against_forgery?) { false }
        end
    end

    def announcements(entries)
        LesliView::Partials::Announcements.new(
            announcements: entries, label: "Announcements",
            link_label: "Open", dismiss_label: "Dismiss"
        )
    end

    def announcement
        {
            id: 7, category: "warning", category_label: "Warning",
            message: "Unsafe <script>alert(1)</script>\nSecond line",
            url: "/details", dismiss_url: "/bell/announcements/7/dismiss"
        }
    end
end
