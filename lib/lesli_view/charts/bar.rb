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
        class Bar < ViewComponent::Base
            attr_reader :id, :title, :labels, :data, :dataset

            def initialize(id: nil, title: nil, labels:[], data: [], datasets:[])
                @id = id
                @title = title
                @labels = labels
                @datasets = datasets

                # ensures we get the highest number as a float to 
                # avoid integer division issues.
                data_max = data.max.to_f
                @data = data.map { |item|
                    {
                        value: item,
                        # Divides each count by the max value.
                        # Multiplies by 100 to scale it.
                        # Uses .round to get whole numbers
                        size: (item / data_max * 100).round 
                    }
                }
            end
        end
    end
end
