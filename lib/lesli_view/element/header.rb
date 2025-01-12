# frozen_string_literal: true

# app/components/lesli_element_header_component.rb
module LesliView
    module Element
        class Header < ViewComponent::Base
            attr_reader :title, :back

            def initialize(title: nil, back: nil)
                @title = title
                @back = back
            end
        end
    end
end
