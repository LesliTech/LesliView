module LesliView
    module Forms
        class BuilderHorizontal < Builder
            def field_control(attribute, label: nil, message: nil, category: nil, icon: nil, **options)
                super(attribute, label: label, message: message, category: category, icon: icon, horizontal: true, **options)
            end

            def field_control_text(attribute, label: nil, message: nil, category: nil, icon: nil, **options)
                super(attribute, label: label, message: message, category: category, icon: icon, horizontal: true, **options)
            end

            def field_control_email(attribute, label: nil, message: nil, category: nil, icon: nil, **options)
                super(attribute, label: label, message: message, category: category, icon: icon, horizontal: true, **options)
            end

            def field_control_checkbox(attribute, label: nil, message: nil, category: nil, icon: nil, **options)
                super(attribute, label: label, message: message, category: category, icon: icon, horizontal: true, **options)
            end

            def field_control_password(attribute, label: nil, message: nil, category: nil, icon: nil, **options)
                super(attribute, label: label, message: message, category: category, icon: icon, horizontal: true, **options)
            end

            def field_control_textarea(attribute, label: nil, message: nil, category: nil, icon: nil, **options)
                super(attribute, label: label, message: message, category: category, icon: icon, horizontal: true, **options)
            end

            def field_textarea(attribute, **options)
                field_control_textarea(attribute, **options)
            end

            def field_select(attribute, choices, options = {}, html_options = {}, label: nil, humanize: true, **field_options)
                field_control_select(attribute, choices, label: label, humanize: humanize, options: options, html_options: html_options, **field_options)
            end

            def field_control_submit(value = nil, options = {})
                super(value, options, horizontal:true)
            end

            def field_control_button(value = nil, options = {}, category: "primary", icon: nil, type: "submit")
                super(value, options, category: category, icon: icon, type: type, horizontal: true)
            end

            def field_control_select(attribute, choices, label: nil, message: nil, category: nil, icon: nil, humanize: true, options: {}, html_options: {})
                super(attribute, choices, label: label, message: message, category: category, icon: icon, horizontal: true, humanize: humanize, options: options, html_options: html_options)
            end
        end
    end
end
