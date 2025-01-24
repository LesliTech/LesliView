# frozen_string_literal: true

# loading view component framework
require "view_component"

# loading gem coomponents
require "lesli_view/version"
require "lesli_view/engine"


# loading layout
require "lesli_view/layout/container"


# loading components
require "lesli_view/components/header"
require "lesli_view/components/toolbar"


# loading elements
require "lesli_view/elements/table"
require "lesli_view/elements/button"
require "lesli_view/elements/tabs"


# loading forms
require "lesli_view/forms/builder"
require "lesli_view/forms/custom"

module LesliView
    class Error < StandardError; end
    # Your code goes here...
end
