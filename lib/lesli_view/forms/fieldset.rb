module LesliView
    module Forms
        module Fieldset
            def fieldset(legend = "", options = {}, category: nil, &block)
                options = options.symbolize_keys
                options[:class] = merge_css_classes("lesli-form-fieldset", css_category(category), options[:class])

                @template.content_tag(:fieldset, options) do
                    legend_html = legend.present? ? @template.content_tag(:legend, legend, class: "lesli-form-legend") : nil
                    @template.safe_join([legend_html, @template.capture(&block)].compact)
                end
            end
        end
    end
end
