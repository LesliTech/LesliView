module LesliView
    module Forms
        class BuilderHorizontal < Builder
            def field_control(attribute, label: nil, message:nil, category:nil, icon:nil)
                super(attribute, label:label, message:message, category:category, icon:icon, horizontal:true)
            end

            def field_select(attribute, choices, options = {}, html_options = {}, label: nil, humanize: true)
                super(attribute, choices, options, html_options, label: label, humanize: humanize, horizontal: true)
            end

            def field_control_submit(value = nil, options = {})
                super(value, options, horizontal:true)
            end

            def field_control_button(value = nil, options = {}, icon:nil, horizontal: false)
                super(value, options, icon:icon, horizontal:true)
            end 

            def field_control_select(attribute, choices, label: nil, message:nil, category:nil, icon:nil, humanize:true)
                super(attribute, choices, label:label, message:message, category:category, icon:icon, horizontal:true, humanize:humanize)
            end 
        end
    end
end
