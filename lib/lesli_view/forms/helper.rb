# frozen_string_literal: true

=begin 

Lesli

Copyright (c) 2025, Lesli Technologies, S. A.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.

Lesli · Ruby on Rails SaaS Development Framework.

Made with ♥ by LesliTech
Building a better future, one line of code at a time.

@contact  hello@lesli.tech
@website  https://www.lesli.tech
@license  GPLv3 http://www.gnu.org/licenses/gpl-3.0.en.html

// · ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~
// · 
=end
module LesliView
    module Forms
        class Helper < ActionView::Helpers::FormBuilder

            def field(attribute, label:nil)
                label_html = label(attribute, label) 
                text_field_html = text_field(attribute)

                @template.content_tag(:div, class: 'lesli-field mb-3') do
                    @template.content_tag(:div, class: 'field') do
                        @template.content_tag(:div, label_html, class: 'field-label is-normal mb-1') +
                        @template.content_tag(:div, class: 'field-body') do
                            @template.content_tag(:div, class: 'field') do
                                @template.content_tag(:div, text_field_html, class: 'control')
                            end
                        end
                    end
                end
            end

            # Custom label method
            def label(method, text = nil, options = {})
                super(method, text, options.merge(class: 'label'))
            end

            # Custom text_field method
            def text_field(method, options = {})
                value = @object.send(method) # Get the value from the model's attribute
                super(method, options.merge(value: value, class: 'input')) # Pass value to the text_field helper
            end

            def submit(value = nil, options = {})
                value ||= "Save"

                # Render the ViewComponent
                @template.render(LesliView::Elements::Button.new(icon: 'save')) do
                    value
                end
            end

            # Optional: customize submit button
            def submit2(value = nil, options = {})
                super(value, options.merge(class: 'button is-primary'))
            end
        end
    end
end
