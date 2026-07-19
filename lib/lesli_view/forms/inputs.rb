module LesliView
    module Forms
        module Inputs
            def label(method, text = nil, options = {})
                options = options.symbolize_keys
                options[:class] = merge_css_classes("lesli-form-label", options[:class])
                super(method, text, options)
            end

            def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
                options = options.symbolize_keys
                options[:class] = merge_css_classes("lesli-form-checkbox", options[:class])
                super(method, options, checked_value, unchecked_value)
            end

            def text_field(method, options = {})
                options = options.symbolize_keys
                options[:class] = merge_css_classes("lesli-form-input", options[:class])
                super(method, options)
            end

            def text_editor(method, options = {})
                input_id = "#{object_name}_#{method}"
                editor_id = "#{input_id}_editor"
                
                hidden_field(method) +
                @template.content_tag("trix-toolbar", "", id: editor_id) +
                @template.content_tag("trix-editor", "", toolbar: editor_id, input: input_id)
            end


            def email_field(method, options = {})
                options = options.symbolize_keys
                options[:class] = merge_css_classes("lesli-form-input", options[:class])
                super(method, options)
            end

            def password_field(method, options = {})
                options = options.symbolize_keys
                options[:class] = merge_css_classes("lesli-form-input", options[:class])
                options[:value] = @object.public_send(method) if @object && !options.key?(:value)
                super(method, options)
            end

            def select(method, choices = nil, options = {}, html_options = {}, &block)
                html_options = html_options.symbolize_keys
                html_options[:class] = merge_css_classes("lesli-form-select", html_options[:class])
                super(method, choices, options, html_options, &block)
            end

            def submit(value = nil, options = {})
                options = options.symbolize_keys
                options[:class] = merge_css_classes("lesli-form-button is-primary", options[:class])
                super(value, options)
            end

        end
    end
end
