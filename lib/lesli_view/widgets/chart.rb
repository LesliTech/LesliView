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
    module Widgets
        class Chart < ViewComponent::Base
            CHART_COMPONENTS = {
                bar: LesliView::Charts::Bar,
                line: LesliView::Charts::Line
            }.freeze

            attr_reader :title, :data, :type

            def initialize(title = nil, data = nil, type: :bar)
                @title = title
                @data = normalize_data(data)
                @type = normalize_type(type)
            end

            def chart_component
                CHART_COMPONENTS.fetch(type)
            end

            def labels
                data.map(&:first)
            end

            def dataset
                data.map(&:last)
            end

            def data?
                data.any?
            end

            def title_id
                @title_id ||= "lesli-chart-widget-title-#{object_id}"
            end

            private

            def normalize_data(value)
                return [] if value.nil?
                return value.to_a if value.respond_to?(:to_a)

                []
            end

            def normalize_type(value)
                value = value.to_s.downcase.to_sym
                return value if CHART_COMPONENTS.key?(value)

                :bar
            end
        end
    end
end
