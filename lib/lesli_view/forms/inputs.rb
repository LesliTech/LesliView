module LesliView
    module Forms
        module Inputs
            def label(method, text = nil, options = {})
                super(method, text, options.merge(class: 'label'))
            end

            def text_field(method, options = {})
                value = @object.send(method)
                super(method, options.merge(value: value, class: 'input'))
            end

            def email_field(method, options = {})
                value = @object.send(method)
                super(method, options.merge(value: value, class: 'input'))
            end

            def password_field(method, options = {})
                value = @object.send(method)
                super(method, options.merge(value: value, class: 'input'))
            end
        end
    end
end
