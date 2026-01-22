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
            attr_reader :label, :url, :icon, :loading, :solid, :info, :success, :warning, :danger, :small, :dispatch, :method, :params, :css_class

            # Adds two numbers together.
            # @param [Integer] a The first number.
            # @param [Integer] b The second number.
            # @return [Integer] The sum of the two numbers.
            def initialize(
                label=nil, 
                url:nil,
                icon: nil, 
                loading: false, 
                solid: false, 
                info: false, 
                success: false, 
                warning: false, 
                danger: false, 
                small: false,
                dispatch:nil,
                method: nil,
                params:nil,
                css_class:nil
            )
                @label = label
                @url = url
                @icon = icon
                @loading = loading
                @solid = solid
                @info = info
                @success = success
                @warning = warning
                @danger = danger
                @small = small
                @dispatch = dispatch
                @method = method
                @params = params
                @css_class = css_class
            end

            def mode
                return :button_to if @method.present?
                return :link if @url.present?
                :button
            end

            def alpine_attributes
                return {} unless @dispatch

                {
                "x-data": "",
                "@click": "$dispatch('#{@dispatch}')"
                }
            end

            def html_classes
                classes = ["button", button_variant]
                classes << "is-light" << "is-outlined" unless solid
                classes << "is-loading" if loading
                classes << "is-small" if small
                classes << css_class 
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
                icon && !label
            end

            def button_content
                if @icon
                    safe_join([
                        content_tag(:span,
                            content_tag(:span, @icon, class: "material-symbols"),
                            class: "icon #{'is-small' if @small}"
                        ),
                        (@icon_only ? nil : content_tag(:span, @label))
                    ].compact)
                else
                    @label
                end
            end
        end  
    end
end
