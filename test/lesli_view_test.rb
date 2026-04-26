require "test_helper"

class LesliViewTest < ActiveSupport::TestCase
    test "it has a version number" do
        assert LesliView::VERSION
    end
    test "it has a build number" do
        assert LesliView::BUILD
    end
end
