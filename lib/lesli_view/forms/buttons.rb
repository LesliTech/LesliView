module LesliView
    module Forms
        module Buttons
            def button(value = nil, options = {})
                value ||= "Save"

                @template.render(LesliView::Elements::Button.new(icon: 'save')) do
                    value
                end
            end

            def submit(value = nil, options = {}, horizontal: false)

                # Extract and merge classes properly
                default_classes = "button is-primary is-outlined"
                custom_classes = options[:class] || ""
                merged_classes = "#{default_classes} #{custom_classes}".strip

                submit_html = super(value, options.merge(class: merged_classes))
                field_build(control_html: submit_html, horizontal: horizontal)
            end
        end
    end
end
