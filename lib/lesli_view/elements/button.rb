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
            attr_reader(
                :label,
                :url,
                :icon,
                :loading,
                :solid,
                :info,
                :success,
                :warning,
                :danger,
                :small,
                :dispatch,
                :method,
                :params,
                :css_class
            )

            def initialize(
                label = nil,
                url: nil,
                icon: nil,
                loading: false,
                solid: true,
                info: true,
                success: false,
                warning: false,
                danger: false,
                small: false,
                dispatch: nil,
                method: nil,
                params: nil,
                css_class: nil
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
                return :button_to if method.present?
                return :link if url.present?

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
                [
                    base_classes,
                    size_classes,
                    variant_classes,
                    loading_classes,
                    css_class
                ].flatten.compact.join(" ")
            end

            def base_classes
                [
                    "border",
                    "inline-flex",
                    "items-center",
                    "justify-center",
                    "gap-2",
                    "font-medium",
                    "whitespace-nowrap",
                    "transition-colors",
                    "duration-150",
                    "focus:outline-none",
                    "focus-visible:ring-2",
                    "focus-visible:ring-offset-2",
                    "disabled:pointer-events-none",
                    "disabled:opacity-50"
                ]
            end

            def size_classes
                return icon_only_size_classes if icon_only?

                small ? small_size_classes : default_size_classes
            end

            def default_size_classes
                [
                    "h-10",
                    "rounded-lg",
                    "px-4",
                    "text-sm"
                ]
            end

            def small_size_classes
                [
                    "h-8",
                    "rounded-md",
                    "px-3",
                    "text-xs"
                ]
            end

            def icon_only_size_classes
                if small
                    [
                        "h-8",
                        "w-8",
                        "rounded-md",
                        "text-xs"
                    ]
                else
                    [
                        "h-10",
                        "w-10",
                        "rounded-lg",
                        "text-sm"
                    ]
                end
            end

            def variant_classes
                solid ? solid_variant_classes : outlined_variant_classes
            end

            def solid_variant_classes
                case color
                when :warning
                    [
                        "border-amber-500",
                        "bg-amber-500",
                        "text-amber-950",
                        "hover:border-amber-600",
                        "hover:bg-amber-600",
                        "focus-visible:ring-amber-500"
                    ]
                when :success
                    [
                        "border-emerald-600",
                        "bg-emerald-600",
                        "text-white",
                        "hover:border-emerald-700",
                        "hover:bg-emerald-700",
                        "focus-visible:ring-emerald-500"
                    ]
                when :danger
                    [
                        "border-rose-600",
                        "bg-rose-600",
                        "text-white",
                        "hover:border-rose-700",
                        "hover:bg-rose-700",
                        "focus-visible:ring-rose-500"
                    ]
                when :info
                    [
                        "border-sky-600",
                        "bg-sky-600",
                        "text-white",
                        "hover:border-sky-700",
                        "hover:bg-sky-700",
                        "focus-visible:ring-sky-500"
                    ]
                else
                    [
                        "border-blue-600",
                        "bg-blue-600",
                        "text-white",
                        "hover:border-blue-700",
                        "hover:bg-blue-700",
                        "focus-visible:ring-blue-500"
                    ]
                end
            end

            def outlined_variant_classes
                case color
                when :warning
                    [
                        "border-amber-300",
                        "bg-transparent",
                        "text-amber-700",
                        "hover:border-amber-400",
                        "hover:bg-amber-50",
                        "focus-visible:ring-amber-500"
                    ]
                when :success
                    [
                        "border-emerald-300",
                        "bg-transparent",
                        "text-emerald-700",
                        "hover:border-emerald-400",
                        "hover:bg-emerald-50",
                        "focus-visible:ring-emerald-500"
                    ]
                when :danger
                    [
                        "border-rose-300",
                        "bg-transparent",
                        "text-rose-700",
                        "hover:border-rose-400",
                        "hover:bg-rose-50",
                        "focus-visible:ring-rose-500"
                    ]
                when :info
                    [
                        "border-sky-300",
                        "bg-transparent",
                        "text-sky-700",
                        "hover:border-sky-400",
                        "hover:bg-sky-50",
                        "focus-visible:ring-sky-500"
                    ]
                else
                    [
                        "border-blue-300",
                        "bg-transparent",
                        "text-blue-700",
                        "hover:border-blue-400",
                        "hover:bg-blue-50",
                        "focus-visible:ring-blue-500"
                    ]
                end
            end

            def loading_classes
                return nil unless loading

                [
                    "pointer-events-none",
                    "cursor-wait",
                    "opacity-80"
                ]
            end

            def color
                return :warning if warning
                return :success if success
                return :danger if danger
                return :info if info

                :primary
            end

            def icon_only?
                icon.present? && label.blank?
            end

            def button_content
                content = []

                if loading
                    content << content_tag(
                        :span,
                        "",
                        class: "h-4 w-4 animate-spin rounded-full border-2 border-current border-r-transparent",
                        aria: {
                            hidden: true
                        }
                    )
                elsif icon.present?
                    content << content_tag(
                        :span,
                        icon,
                        class: "material-symbols text-[20px] leading-none",
                        aria: {
                            hidden: true
                        }
                    )
                end

                content << content_tag(:span, label) if label.present?

                safe_join(content)
            end
        end
    end
end
