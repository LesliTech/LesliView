require "test_helper"

class LesliViewTest < ActiveSupport::TestCase
    test "it has a version number" do
        assert LesliView::VERSION
    end
    test "it has a build number" do
        assert LesliView::BUILD
    end

    test "it loads Lexxy within Rails" do
        assert defined?(ActionText::Engine)
        assert defined?(Lexxy::Engine)
    end
end
