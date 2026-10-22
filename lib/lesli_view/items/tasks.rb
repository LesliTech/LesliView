=begin

Lesli

Copyright (c) 2026, Lesli Technologies, S. A.

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
    module Items
        class Tasks < ViewComponent::Base
            attr_reader :resource

            def initialize(resource)
                @resource = resource
            end

            def task_class
                resource.class.lesli_tasks_class
            end

            def tasks
                resource.public_send(
                    resource.class.lesli_tasks_association_name
                )
            end

            def scope_key
                ActiveSupport::Inflector
                    .underscore(task_class.name)
                    .tr("/", "_")
            end
        end
    end
end
