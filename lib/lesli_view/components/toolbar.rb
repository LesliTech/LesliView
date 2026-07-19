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
    module Components
        class Toolbar < ViewComponent::Base
            renders_one :filters
            renders_one :actions

            attr_reader :search_placeholder, :initial_value, :url, :search_name

            def initialize(search_placeholder = nil, initial_value: nil, url: nil, search_name: :search)
                @search_placeholder = search_placeholder
                @initial_value = initial_value
                @url = url
                @search_name = search_name
            end

            def form_url
                url.presence || request.path
            end

            def search_value
                return initial_value unless initial_value.nil?

                request.query_parameters[search_name.to_s]
            end

            def searching?
                search_value.present?
            end

            def clear_url
                query = request.query_parameters.except(search_name.to_s)
                return form_url if query.empty?

                "#{form_url}?#{query.to_query}"
            end

            def placeholder
                search_placeholder.presence || I18n.t("lesli_view.toolbar.placeholder", default: "Search...")
            end

            def search_label
                I18n.t("lesli_view.toolbar.search", default: "Search")
            end

            def clear_label
                I18n.t("lesli_view.toolbar.clear", default: "Clear search")
            end
        end
    end
end
