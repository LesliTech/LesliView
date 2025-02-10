module LesliView
    module Forms
        module Fieldset
            def fieldset(legend = "", options = {}, category: nil, &block)
                options[:class] = ["lesli-form-fieldset", "box", "pr-6", "is-#{category}"]
                options[:class].push("pt-5") unless legend.present?

                @template.content_tag(:fieldset, options) do
                    legend_html = legend.present? ? @template.content_tag(:h5, legend, class: ["is-size-5", "mb-5", "ml-2"]) : nil
                    @template.safe_join([legend_html, @template.capture(&block)].compact)
                end
            end
        end
    end
end
