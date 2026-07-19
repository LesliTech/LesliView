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
    module Elements
        class Button < ViewComponent::Base
            attr_reader :label, :url, :icon, :loading, :solid, :light,
                :info, :success, :warning, :danger, :small, :dispatch,
                :method, :params, :css_class, :aria_label, :disabled,
                :button_type, :data

            def initialize(
                label = nil,
                url: nil,
                icon: nil,
                loading: false,
                solid: true,
                light: false,
                info: true,
                success: false,
                warning: false,
                danger: false,
                small: false,
                dispatch: nil,
                method: nil,
                params: nil,
                css_class: nil,
                aria_label: nil,
                disabled: false,
                type: :button,
                data: {}
            )
                @label = label
                @url = url
                @icon = icon
                @loading = loading
                @solid = solid
                @light = light
                @info = info
                @success = success
                @warning = warning
                @danger = danger
                @small = small
                @dispatch = dispatch
                @method = method
                @params = params
                @css_class = css_class
                @aria_label = aria_label
                @disabled = disabled
                @button_type = type
                @data = data
            end

            def mode
                return :button_to if @method.present?
                return :link if @url.present?
                :button
            end

            def alpine_attributes
                return {} unless dispatch.present?

                {
                    "x-data": "",
                    "@click": "$dispatch('#{dispatch}')"
                }
            end

            def html_classes
                classes = ["lesli-button", button_variant]
                classes << "is-outlined" unless solid
                classes << "is-light" if light
                classes << "is-loading" if loading
                classes << "is-small" if small
                classes << "is-icon-only" if icon_only?
                classes << css_class if css_class.present?
                classes.join(" ")
            end

            def button_variant
                return "is-warning" if warning
                return "is-success" if success
                return "is-danger" if danger
                return "is-info" if info
                "is-primary"
            end

            def icon_only?
                icon.present? && visible_label.blank?
            end

            def disabled?
                disabled || loading
            end

            def visible_label
                label.presence || (content if content?)
            end

            def accessible_label
                aria_label.presence || (icon.to_s.humanize if icon_only?)
            end

            def html_data
                { turbo_frame: "_top" }.merge(data || {})
            end

            def common_attributes
                attributes = {
                    class: html_classes,
                    data: html_data,
                    aria: {
                        label: accessible_label,
                        busy: loading || nil,
                        disabled: disabled? || nil
                    }.compact
                }

                attributes.merge(alpine_attributes)
            end

            def button_content
                parts = []

                if icon.present?
                    parts << content_tag(:span, class: "lesli-icon", aria: { hidden: true }) do
                        content_tag(:span, icon, class: "material-symbols")
                    end
                end

                parts << content_tag(:span, visible_label) if visible_label.present?
                safe_join(parts)
            end
        end  
    end
end
