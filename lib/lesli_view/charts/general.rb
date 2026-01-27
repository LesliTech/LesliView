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
                :series, 
                :height, 
                :compact
            )

            def initialize(
                id:nil, 
                title:nil, 
                subtitle:nil, 
                database:nil,
                labels:nil, 
                series:nil, 
                serie:nil, 
                height:"400px",
                compact:false
            )
                @id = id || "lesli-chart-#{rand(1000)}" 
                @title = title
                @subtitle = subtitle
                @labels = labels
                @series = series
                @height = height
                @compact = compact

                @series = [{ name: title, data: serie }] if serie
                @labels, @series = database_to_series(database) unless @series
            end

            def type
                nil
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
            def database_to_series(data)

                # Placeholder for x-axis labels.
                # Chart.js can infer labels from `{ x, y }` points,
                # but this is kept for future compatibility and flexibility.
                labels = []

                # Group records by series name
                # Example: group all "Chrome" rows together
                series = data
                .group_by { |r| r[:name] }
                .map do |name, records|

                    # Build a Chart.js-compatible series
                    {
                        # Series name (used in legend and tooltips)
                        name: name,

                        # Convert each database row into an (x, y) point
                        data: records.map do |record|
                            {
                                # X-axis value (date, category, etc.)
                                x: record[:label],

                                # Y-axis value (must be numeric)
                                y: record[:data]
                            }
                        end
                    }
                end

                [labels, series]
            end
        end
    end
end
