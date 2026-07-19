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
    module Charts
        class General < ViewComponent::Base
            attr_reader(
                :id,
                :title,
                :subtitle,
                :labels,
                :datasets,
                :height,
                :compact
            )

            def initialize(
                id: nil,
                title: nil,
                subtitle: nil,
                labels: nil,
                dataset: nil,
                datasets: nil,
                database_to_dataset: nil,
                database_to_datasets: nil,
                height: "400px",
                compact: false
            )
                @id = id.presence || "lesli-chart-#{object_id}"
                @title = title
                @subtitle = subtitle
                @labels = Array(labels)
                @height = normalize_height(height)
                @compact = !!compact

                source_datasets = datasets
                source_datasets = [{ label: title, data: dataset }] unless dataset.nil?
                source_datasets = convert_database_to_dataset(database_to_dataset) if database_to_dataset
                source_datasets = convert_database_to_datasets(database_to_datasets) if database_to_datasets
                @datasets = normalize_datasets(source_datasets)
            end

            def type
                nil
            end

            def chart_config
                {
                    id: id,
                    type: type,
                    datasets: datasets,
                    labels: labels,
                    compact: compact
                }
            end

            def title_id
                @title_id ||= "#{id}-title"
            end

            def convert_database_to_dataset(data)
                [{ label: title, data: data.map { |record| { x: record["xaxiskey"], y: record["yaxiskey"] } } }]
            end

            # Transforms a database query result into a structure compatible with Chart.js
            #
            # Expected input:
            #   An enumerable of records responding to:
            #     - :name  → series name (ex: browser, category, status)
            #     - :label → x-axis value (ex: date, category label)
            #     - :data  → y-axis value (numeric)
            #
            #   Example: 
            #       browsers = current_user.account.audit.account_devices
            #       .group(:agent_browser, :created_at)
            #       .select(
            #           'created_at as label',
            #           'agent_browser as name',
            #           'sum(agent_count) as data'
            #       )
            #
            def convert_database_to_datasets(data)
                # Group records by series name
                # Example: group all "Chrome" rows together
                data
                .group_by { |records| records['dataname'] }
                .map do |name, records|
                    {
                        # Series name (used in legend and tooltips)
                        label: name,

                        # Convert each database row into an (x, y) point
                        data: records.map do |record|
                            {
                                # X-axis value (date, category, etc.)
                                x: record['xaxiskey'],

                                # Y-axis value (must be numeric)
                                y: record['yaxiskey']
                            }
                        end
                    }
                end
            end

            # Preserve the original public conversion helpers.
            alias_method :database_to_dataset, :convert_database_to_dataset
            alias_method :database_to_datasets, :convert_database_to_datasets

            def dataset_defaults
                {}
            end

            private

            def normalize_datasets(value)
                Array(value).map do |dataset|
                    attributes = dataset.respond_to?(:to_h) ? dataset.to_h.symbolize_keys : { data: Array(dataset) }
                    dataset_defaults.merge(attributes)
                end
            end

            def normalize_height(value)
                value = value.to_s
                return value if value.match?(/\A\d+(?:\.\d+)?(?:px|rem|em|vh|vw|%)\z/)

                "400px"
            end
        end
    end
end
