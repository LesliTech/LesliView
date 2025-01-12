# frozen_string_literal: true

# app/components/lesli_application_container_component.rb
module LesliView
    module Layout
        class Container < ViewComponent::Base
            attr_reader :turbo_frame_id
            attr_reader :dashboard
        
            def initialize(turbo_frame_id, dashboard: false)
                @turbo_frame_id = turbo_frame_id
                @dashboard = dashboard
            end
        end        
    end
end
