module LesliView
    module Element
        class Button < ViewComponent::Base
            attr_reader :icon, :loading, :solid, :info, :success, :warning, :danger, :small

            def initialize(icon: nil, loading: false, solid: false, info: false, success: false, warning: false, danger: false, small: false)
                @icon = icon
                @loading = loading
                @solid = solid
                @info = info
                @success = success
                @warning = warning
                @danger = danger
                @small = small
            end

            def button_classes
                classes = ["button", button_variant]
                classes << "is-light" << "is-outlined" unless solid
                classes << "is-loading" if loading
                classes << "is-small" if small
                classes.join(" ")
            end

            def button_variant
                return "is-warning" if warning
                return "is-success" if success
                return "is-danger" if danger
                return "is-info" if info
                "is-primary"
            end

            def icon_only?(content_present)
                icon && !content_present
            end
        end  
    end
end
