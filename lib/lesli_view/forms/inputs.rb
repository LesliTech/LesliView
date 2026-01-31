module LesliView
    module Forms
        module Inputs
            def label(method, text = nil, options = {})
                super(method, text, options.merge(class: 'label'))
            end

            def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
                value = @object.send(method)
                super(method, options, checked_value, unchecked_value)
            end

            def text_field(method, options = {})
                value = @object.send(method)
                super(method, options.merge(value: value, class: 'input'))
            end

            def text_editor(method, options = {})
                input_id = "#{object_name}_#{method}"
                editor_id = "#{input_id}_editor"
                
                hidden_field(method) +
                @template.content_tag("trix-toolbar", "", id: editor_id) +
                @template.content_tag("trix-editor", "", toolbar: editor_id, input: input_id)
            end


            def email_field(method, options = {})
                value = @object.send(method)
                super(method, options.merge(value: value, class: 'input'))
            end

            def password_field(method, options = {})
                value = @object.send(method)
                super(method, options.merge(value: value, class: 'input'))
            end

            def submit(value=nil, options = {})
                # Extract and merge classes properly
                default_classes = "button is-primary"
                custom_classes = options[:class] || ""
                merged_classes = "#{default_classes} #{custom_classes}".strip
                super(value, options.merge(class: merged_classes))
            end 
        end
    end
end
