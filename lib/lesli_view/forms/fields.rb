module LesliView
    module Forms
        module Fields
            def field(attribute, label: nil, horizontal: false)
                label_html = label(attribute, label)
                text_field_html = text_field(attribute)

                field_build(
                    label_html: label_html,
                    control_html: text_field_html,
                    horizontal: horizontal
                )
            end

            def lesli_text_field(attribute, label: nil, horizontal: false)
                label_html = label(attribute, label)
                text_field_html = text_field(attribute)

                field_build(
                    label_html: label_html,
                    control_html: text_field_html,
                    horizontal: horizontal
                )
            end

            def lesli_email_field(attribute, label: nil, help:nil, category:nil, horizontal: false)
                label_html = label(attribute, label)
                control_html = email_field(attribute)
                #message_html = 

                field_build(
                    label_html: label_html,
                    control_html: text_field_html,
                    horizontal: horizontal
                )
            end

            def lesli_help_text(text, category)
                @template.content_tag(:p, text, class: "help #{css_category(category)}")
            end

            def field_build(
                label_html:nil, 
                control_html:nil, 
                message_html:nil,
                horizontal:false, 
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
                                control_html + message_html
                            end
                        end
                    end
                end
            end

            private

            def field_params params
                {
                    label: nil,
                    icon: nil,
                    info: nil,
                    warning: nil,
                    danger: nil,
                    horizontal: false
                }.merge(options)
            end

            def icon_html(icon_class, position)
                return ''.html_safe unless icon_class

                @template.content_tag(:span, class: "icon is-small is-#{position}") do
                    @template.content_tag(:i, '', class: icon_class)
                end
            end          
        end
    end
end  
