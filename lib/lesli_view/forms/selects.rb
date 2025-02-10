module LesliView
    module Forms
        module Selects

            def field_select(attribute, choices, options = {}, html_options = {}, label: nil, horizontal: false, humanize: true)
                choices = choices.map { |k, v| [k.humanize.capitalize, v] } if humanize
                value = @object.send(attribute)
                label_html = label(attribute, label)
                select_html = select(attribute, choices, options, html_options.merge(value: value))

                field_build(
                    label_html: label_html,
                    control_html: @template.content_tag(:div, select_html, class: "select is-fullwidth"),
                    horizontal: horizontal
                )
            end
        end
    end
end
