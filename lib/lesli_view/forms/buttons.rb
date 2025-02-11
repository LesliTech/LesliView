module LesliView
    module Forms
        module Buttons
            def button(value = nil, options = {})
                value ||= "Save"

                @template.render(LesliView::Elements::Button.new(icon: 'save')) do
                    value
                end
            end
        end
    end
end
