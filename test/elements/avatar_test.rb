require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/elements/avatar"

module LesliView
    module Elements
        class AvatarTest < Minitest::Test
            def test_renders_initials_with_component_classes
                html = Avatar.new(name: "Ada Lovelace").render_in(ActionView::Base.empty)

                assert_includes html, "AL"
                assert_includes html, "lesli-avatar-medium"
                assert_includes html, "lesli-avatar-medium-text"
                assert_includes html, "lesli-avatar"
                refute_includes html, "has-background-grey-lighter"
                refute_includes html, "has-text-weight-bold"
                refute_includes html, "is-size-"
            end

            def test_renders_an_image_that_fills_the_avatar
                html = Avatar.new(image: "/avatar.png", name: "Ada Lovelace", size: "small")
                    .render_in(ActionView::Base.empty)

                assert_includes html, "lesli-avatar-small"
                assert_includes html, 'class="lesli-avatar-image"'
                assert_includes html, 'src="/avatar.png"'
            end

            def test_renders_the_large_size
                html = Avatar.new(name: "Grace Hopper", size: "large").render_in(ActionView::Base.empty)

                assert_includes html, "lesli-avatar-large"
                assert_includes html, "lesli-avatar-large-text"
            end
        end
    end
end
