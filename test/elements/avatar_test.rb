require "minitest/autorun"
require "rails/version"
require "action_view"
require "view_component"
require_relative "../../lib/lesli_view/elements/avatar"

module LesliView
    module Elements
        class AvatarTest < Minitest::Test
            def test_renders_initials_with_tailwind_classes
                html = Avatar.new(name: "Ada Lovelace").render_in(ActionView::Base.empty)

                assert_includes html, "AL"
                assert_includes html, "size-[120px]"
                assert_includes html, "text-[2rem]"
                assert_includes html, "rounded-full"
                assert_includes html, "border-[0.1px]"
                assert_includes html, "border-slate-300"
                assert_includes html, "bg-slate-100"
                refute_includes html, "has-background-grey-lighter"
                refute_includes html, "has-text-weight-bold"
                refute_includes html, "is-size-"
            end

            def test_renders_an_image_that_fills_the_avatar
                html = Avatar.new(image: "/avatar.png", name: "Ada Lovelace", size: "small")
                    .render_in(ActionView::Base.empty)

                assert_includes html, "size-[60px]"
                assert_includes html, 'class="h-full w-full object-cover"'
                assert_includes html, 'src="/avatar.png"'
            end

            def test_renders_the_large_size
                html = Avatar.new(name: "Grace Hopper", size: "large").render_in(ActionView::Base.empty)

                assert_includes html, "size-[180px]"
                assert_includes html, "text-5xl"
            end
        end
    end
end
