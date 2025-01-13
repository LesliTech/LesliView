# frozen_string_literal: true

# loading view component framework
require "view_component"

# loading gem coomponents
require "lesli_view/version"
require "lesli_view/engine"


# loading layout
require "lesli_view/layout/container"


# loading elements
require "lesli_view/element/header"
require "lesli_view/element/table"
require "lesli_view/element/button"
require "lesli_view/element/toolbar"

module LesliView
    class Error < StandardError; end
    # Your code goes here...
end
