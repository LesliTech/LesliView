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
        class Builder < ActionView::Helpers::FormBuilder

            def field_select_enum(attribute, choices, options = {}, html_options = {}, label: nil, horizontal: false)
                field_select(attribute, choices.map {|k, v| [k.humanize.capitalize, v]}, options, html_options, label: label, horizontal: horizontal)
            end

            def field_select(attribute, choices, options = {}, html_options = {}, label:nil, horizontal:false)

                # Set a default class for styling the select control
                html_options[:class] ||= 'select'

                # Get the value from the model's attribute
                value = @object.send(attribute) 

                label_html = label(attribute, label) 
                select_html = select(attribute, choices, options, html_options.merge(value: value))

                field_wrapper(
                    label_html: label_html,
                    control_html: @template.content_tag(:div, select_html, class: "select is-fullwidth"),
                    horizontal: horizontal
                )
            end

            def field(attribute, label: nil, horizontal: false)
                label_html = label(attribute, label) 
                text_field_html = text_field(attribute)

                field_wrapper(
                    label_html:label_html, 
                    control_html:text_field_html, 
                    horizontal:horizontal
                )
            end              

            def label(method, text = nil, options = {})
                super(method, text, options.merge(class: 'label'))
            end

            def text_field(method, options = {})
                value = @object.send(method) # Get the value from the model's attribute
                super(method, options.merge(value: value, class: 'input')) # Pass value to the text_field helper
            end

            def button(value = nil, options = {})
                value ||= "Save"

                # Render the ViewComponent
                @template.render(LesliView::Elements::Button.new(icon: 'save')) do
                    value
                end
            end

            def submit(value = nil, options = {}, horizontal:false)
                submit_html = super(value, options.merge(class: 'button is-primary'))
                field_wrapper(control_html:submit_html, horizontal:horizontal)
            end

            private 

            def field_wrapper label_html:nil, control_html:nil, horizontal:false

                # Conditionally add 'is-horizontal' if horizontal is true
                field_classes = ['field']
                field_classes << 'is-horizontal' if horizontal

                @template.content_tag(:div, class: 'lesli-field mb-3') do
                    @template.content_tag(:div, class: field_classes.join(' ')) do
                        @template.content_tag(:div, label_html, class: 'field-label is-normal mb-1') +
                        @template.content_tag(:div, class: 'field-body') do
                            @template.content_tag(:div, class: 'field') do
                                @template.content_tag(:div, control_html, class: 'control')
                            end
                        end
                    end
                end
            end 
        end

        class BuilderHorizontal < Builder
            def field(attribute, label:nil)
                super(attribute, label:label, horizontal:true)
            end

            def field_select(attribute, choices, options = {}, html_options = {}, label:nil)
                super(attribute, choices, options = {}, html_options = {}, label:nil, horizontal:true)
            end 

            def submit(value = nil, options = {})
                super(value, options, horizontal:true)
            end
        end 
    end
end
