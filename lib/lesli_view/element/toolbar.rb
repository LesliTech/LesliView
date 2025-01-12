
# lib/lesli_view/element/toolbar_component.rb
module LesliView
    module Element
        class Toolbar < ViewComponent::Base
            attr_reader :search_placeholder, :initial_value, :pagination
        
            def initialize(search_placeholder = "Search...", initial_value: nil, pagination: true)
                @search_placeholder = search_placeholder
                @initial_value = initial_value
                @pagination = pagination
            end
        end
    end
end
