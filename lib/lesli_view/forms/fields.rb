module LesliView
    module Forms
        module Fields
            def field_control(attribute, label: nil, message: nil, category: nil, icon: nil, horizontal: false, **options)
                field_control_text(attribute, label: label, message: message, category: category, icon: icon, horizontal: horizontal, **options)
            end

            def field_control_checkbox(attribute, label: nil, message: nil, category: nil, icon: nil, horizontal: false, **options)
                label_text = label.presence || attribute.to_s.humanize
                checkbox_html = check_box(attribute, options, true, false)
                control_html = @template.content_tag(:label, class: "lesli-form-checkbox-label") do
                    @template.safe_join([
                        checkbox_html,
                        @template.content_tag(:span, label_text)
                    ])
                end

                field_control_builder(
                    control_html: control_html,
                    message_text: message,
                    category: category,
                    horizontal: horizontal
                )
            end

            def field_control_password(attribute, label: nil, message: nil, category: nil, icon: nil, horizontal: false, **options)
                label_html = label(attribute, label)
                control_html = password_field(attribute, options)

                field_control_builder(
                    label_html: label_html,
                    control_html: control_html,
                    message_text: message,
                    category: category,
                    icon: icon,
                    horizontal: horizontal
                )
            end

            def field_control_text(attribute, label: nil, message: nil, category: nil, icon: nil, horizontal: false, **options)
                label_html = label(attribute, label)
                control_html = text_field(attribute, options)

                field_control_builder(
                    label_html: label_html,
                    control_html: control_html,
                    message_text: message,
                    category: category,
                    icon: icon,
                    horizontal: horizontal
                )
            end

            def field_control_email(attribute, label: nil, message: nil, category: nil, icon: nil, horizontal: false, **options)
                label_html = label(attribute, label)
                control_html = email_field(attribute, options)

                field_control_builder(
                    label_html: label_html,
                    control_html: control_html,
                    message_text: message,
                    category: category,
                    horizontal: horizontal,
                    icon: icon
                )
            end

            def field_control_select(attribute, choices, label: nil, message: nil, category: nil, icon: nil, horizontal: false, humanize: true, options: {}, html_options: {})
                choices = choices.map { |text, value| [text.to_s.humanize, value] } if humanize
                label_html = label(attribute, label)
                select_html = select(attribute, choices, options, html_options)

                field_control_builder(
                    label_html: label_html,
                    control_html: @template.content_tag(:div, select_html, class: "lesli-form-select-wrapper"),
                    message_text: message,
                    category: category,
                    icon: icon,
                    horizontal: horizontal
                )
            end

            def field_control_textarea(attribute, label: nil, message: nil, category: nil, icon: nil, horizontal: false, **options)
                label_html = label == false ? nil : label(attribute, label)
                control_html = rich_textarea(attribute, options)

                field_control_builder(
                    label_html: label_html,
                    control_html: control_html,
                    message_text: message,
                    category: category,
                    horizontal: horizontal,
                    icon: icon
                )
            end

            # Backward-compatible shorthand used by older Lesli forms.
            def field_textarea(attribute, **options)
                field_control_textarea(attribute, **options)
            end

            def field_select(attribute, choices, options = {}, html_options = {}, label: nil, humanize: true, **field_options)
                field_control_select(
                    attribute,
                    choices,
                    label: label,
                    humanize: humanize,
                    options: options,
                    html_options: html_options,
                    **field_options
                )
            end

            def field_control_submit(value = nil, options = {}, horizontal: false)
                submit_html = submit(value, options)
                field_control_builder(control_html: submit_html, horizontal: horizontal)
            end

            def field_control_button(value = nil, options = {}, category: "primary", icon: nil, type: "submit", horizontal: false)
                options = options.symbolize_keys
                button_classes = merge_css_classes("lesli-form-button", css_category(category), options.delete(:class))

                button_html = @template.content_tag(:button, class: button_classes, type: type, **options) do
                    content = []
                    if icon.present?
                        content << @template.content_tag(:span, class: "lesli-form-button-icon", aria: { hidden: true }) do
                            @template.content_tag(:span, icon, class: "material-symbols")
                        end
                    end
                    content << @template.content_tag(:span, value) if value.present?
                    @template.safe_join(content)
                end
                field_control_builder(control_html: button_html, horizontal: horizontal)
            end

            def field_control_builder(
                label_html: nil,
                control_html: nil,
                message_text: nil,
                horizontal: false,
                category: nil,
                icon: nil,
                &block
            )
                field_classes = merge_css_classes("lesli-form-field", horizontal && "is-horizontal", css_category(category))
                control_classes = merge_css_classes("lesli-form-control", icon.present? && "has-icon")
                captured_control = block_given? ? @template.capture(&block) : control_html

                @template.content_tag(:div, class: field_classes) do
                    content = []
                    content << @template.content_tag(:div, label_html, class: "lesli-form-label-wrapper") if label_html.present?
                    content << @template.content_tag(:div, class: "lesli-form-field-body") do
                        body = []
                        body << @template.content_tag(:div, class: control_classes) do
                            @template.safe_join([captured_control, icon_html(icon)].compact)
                        end
                        if message_text.present?
                            body << @template.content_tag(:p, message_text, class: merge_css_classes("lesli-form-help", css_category(category)))
                        end
                        @template.safe_join(body)
                    end
                    @template.safe_join(content)
                end
            end

            private

            def icon_html(icon_name)
                return unless icon_name.present?

                @template.content_tag(:span, class: "lesli-form-icon", aria: { hidden: true }) do
                    @template.content_tag(:span, icon_name, class: "material-symbols-outlined")
                end
            end
        end
    end
end  
