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
        class Table < ViewComponent::Base
            attr_reader :id, :class_name, :pagination, :loading, :headless, :columns, :records, :link

            def initialize(id: nil, class_name: "is-striped", pagination: nil, loading: false, headless: false, columns:, records:, link: nil)
                @id = id
                @class_name = class_name
                @pagination = pagination
                @loading = loading
                @headless = headless
                @columns = columns
                @records = records
                @link = link
            end

            def table_header_class(column)
                column[:field] == "id" || column[:align] == "center" ? "has-text-centered" : ""
            end

            def table_body_class(column)
                column[:field] == "id" || column[:align] == "center" ? "has-text-centered" : ""
            end
        end  
    end
end
