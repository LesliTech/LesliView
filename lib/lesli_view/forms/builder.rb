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

            def field_select(attribute, choices, options = {}, html_options = {}, label: nil, horizontal: false, humanize:true)

                choices = choices.map {|k, v| [k.humanize.capitalize, v]} if humanize

                # Get the value from the model's attribute
                value = @object.send(attribute)

                # Generate the label HTML
                label_html = label(attribute, label)

                # Create the select HTML
                select_html = select(attribute, choices, options, html_options.merge(value: value))

                # Use field_build to generate the final field layout
                field_build(
                    label_html: label_html,
                    control_html: @template.content_tag(:div, select_html, class: "select is-fullwidth"),
                    horizontal: horizontal
                )
            end

            def field(attribute, label: nil, horizontal: false)
                label_html = label(attribute, label) 
                text_field_html = text_field(attribute)

                field_build(
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

            def email_field(method, options = {})
                # Get the value from the model's attribute
                value = @object.send(method) 

                # Pass value to the text_field helper
                super(method, options.merge(value: value, class: 'input')) 
            end

            def button(value = nil, options = {})
                value ||= "Save"

                # Render the ViewComponent
                @template.render(LesliView::Elements::Button.new(icon: 'save')) do
                    value
                end
            end

            def submit(value = nil, options = {}, horizontal:false)
                submit_html = super(value, options.merge(class: 'button is-primary is-outlined'))
                field_build(control_html:submit_html, horizontal:horizontal)
            end

            def field_build(label_html:nil, control_html:nil, icon:nil, horizontal:false, &block)

                # Conditionally add 'is-horizontal' if horizontal is true
                field_classes = ['field']
                field_classes << 'is-horizontal' if horizontal

                @template.content_tag(:div, class: 'lesli-form-field mb-3') do
                    @template.content_tag(:div, class: field_classes.join(' ')) do
                        @template.content_tag(:div, label_html, class: 'field-label is-normal mb-1') +
                        @template.content_tag(:div, class: 'field-body') do
                            @template.content_tag(:div, class: 'field') do
                                @template.content_tag(:div, control_html, class: 'control', &block)
                            end
                        end
                    end
                end
            end

            def fieldset(legend="", options={}, category:nil, &block)
                options[:class] = ["lesli-form-fieldset", "box", "pr-6", "is-#{category}"]
                options[:class].push("pt-5") unless legend.present?
                #@template.field_set_tag(legend, options, &block)

                @template.content_tag(:fieldset, options) do
                    if legend.present?
                        legend_html = @template.content_tag(:h5, legend, class: ["is-size-5", "mb-5", "ml-2"]) 
                    end 
                    
                    # Ensure proper concatenation
                    @template.safe_join([legend_html, @template.capture(&block)].compact) 
                end
            end
        end

        class BuilderHorizontal < Builder
            def field(attribute, label:nil)
                super(attribute, label:label, horizontal:true)
            end

            def field_select(attribute, choices, options = {}, html_options = {}, label:nil, humanize:true)
                super(attribute, choices, options = {}, html_options = {}, label:nil, humanize:humanize, horizontal:true)
            end 

            def submit(value = nil, options = {})
                super(value, options, horizontal:true)
            end

            def field_build(label_html:nil, control_html:nil, horizontal:true)
                super(label_html:label_html, control_html:control_html, horizontal:horizontal)
            end
        end 
    end
end
