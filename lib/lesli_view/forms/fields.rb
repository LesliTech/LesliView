module LesliView
    module Forms
        module Fields
            def field_control(attribute, label: nil, message:nil, category:nil, icon:nil, horizontal: false)
                field_control_text(attribute, label:label, message:message, category:category, icon:icon, horizontal:horizontal)
            end

            def field_control_checkbox(attribute, label: nil, message:nil, category:nil, icon:nil, horizontal: false)
                label_html = label(attribute, label)
                text_field_html = check_box(attribute, {}, true, false)

                field_control_builder(
                    label_html: label_html,
                    control_html: text_field_html,
                    horizontal: horizontal
                )
            end

            def field_control_text(attribute, label: nil, message:nil, category:nil, icon:nil, horizontal: false)
                label_html = label(attribute, label)
                text_field_html = text_field(attribute)

                field_control_builder(
                    label_html: label_html,
                    control_html: text_field_html,
                    horizontal: horizontal
                )
            end

            def field_control_email(attribute, label: nil, message:nil, category:nil, icon:nil, horizontal: false)
                label_html = label(attribute, label)
                control_html = email_field(attribute)

                field_control_builder(
                    label_html: label_html,
                    control_html: control_html,
                    horizontal: horizontal,
                    icon:icon
                )
            end

            def field_text_editor(attribute, label:nil, message:nil, category:nil, icon:nil, horizontal: false)

                label_html = label(attribute, label)
                control_html = text_editor(attribute)

                field_control_builder(
                    label_html: label_html,
                    control_html: control_html,
                    horizontal: horizontal,
                    icon:icon
                )
            end

            def field_control_select(attribute, choices, label: nil, message:nil, category:nil, icon:nil, horizontal: false, humanize:true)
                choices = choices.map { |k, v| [k.humanize.capitalize, v] } if humanize
                value = @object.send(attribute)
                label_html = label(attribute, label)
                select_html = select(attribute, choices, {}, { value: value })

                field_control_builder(
                    label_html: label_html,
                    control_html: @template.content_tag(:div, select_html, class: "select is-fullwidth"),
                    horizontal: horizontal
                )
            end

            def field_control_submit(value = nil, options = {}, horizontal: false)
                submit_html = submit(value, options)
                field_control_builder(control_html: submit_html, horizontal: horizontal)
            end

            def field_control_button(value = nil, options = {}, category:"primary", icon:nil, type:"submit", horizontal: false)
                # Merge user-provided classes with default button classes
                button_classes = ["button", "is-#{category}"]

                button_html = @template.content_tag(:button, class: button_classes, type: type, **options.except(:class)) do
                    html = "".html_safe
                    if icon.present?
                        html << @template.content_tag(:span, class: "icon") do
                            @template.content_tag(:span, icon, class: "material-icons")
                        end
                    end
                    html << @template.content_tag(:span, value) if value.present?
                    html
                end
                field_control_builder(control_html: button_html, icon:nil, horizontal: horizontal)
            end

            def field_control_builder(
                label_html:nil, 
                control_html:nil, 
                message_text:nil,
                horizontal:false, 
                category:nil,
                icon:nil, 
                &block
            )

                icon_left = icon
                icon_right = nil

                # Conditionally add 'is-horizontal' if horizontal is true
                field_classes = ['field']
                field_classes << 'is-horizontal' if horizontal

                control_classes = ['control']
                control_classes << 'has-icons-left' if icon_left
                control_classes << 'has-icons-right' if icon_right

                help_class = ""

                @template.content_tag(:div, class: 'lesli-form-field mb-3') do
                    @template.content_tag(:div, class: field_classes.join(' ')) do
                        @template.content_tag(:div, label_html, class: 'field-label is-normal mb-1') +
                        @template.content_tag(:div, class: 'field-body') do
                            @template.content_tag(:div, class: 'field') do
                                control_html = @template.content_tag(:div, class: control_classes.join(' ')) do
                                    content = ''.html_safe
                                    content << (block_given? ? @template.capture(&block) : control_html)
                                    content << icon_html(icon_left, 'left') if icon_left
                                    content << icon_html(icon_right, 'right') if icon_right
                                    content
                                end
                                control_html + @template.content_tag(:p, message_text, class: "help #{css_category(category)}")
                            end
                        end
                    end
                end
            end

            private

            def icon_html(icon_class, position)
                return ''.html_safe unless icon_class

                @template.content_tag(:span, class: "icon is-small is-#{position}") do
                    #@template.content_tag(:i, '', class: icon_class)
                    @template.content_tag(:span, icon_class, class: "material-icons")
                end
            end          
        end
    end
end  
