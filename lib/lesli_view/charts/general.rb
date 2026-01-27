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
                id:nil, 
                title:nil, 
                subtitle:nil, 
                labels:nil, 
                dataset:nil,
                datasets:nil, 
                database_to_dataset:nil,
                database_to_datasets:nil,
                height:"400px",
                compact:false
            )
                @id = id || "lesli-chart-#{rand(1000)}" 
                @title = title
                @subtitle = subtitle
                @labels = labels
                @datasets = datasets
                @height = height
                @compact = compact

                @datasets = [{ name: title, data: dataset }] if dataset
                @datasets = database_to_dataset(database_to_dataset) if database_to_dataset
                @datasets = database_to_datasets(database_to_datasets) if database_to_datasets
            end

            def type
                nil
            end

            def database_to_dataset(data)
                [{ data: data.map { |d| { x: d['xaxiskey'], y: d['yaxiskey'] }}}]
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
            def database_to_datasets(data)

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
        end
    end
end
