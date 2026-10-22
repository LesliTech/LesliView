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
    module Items
        class Discussions < ViewComponent::Base
            attr_reader :comment, :resource

            def initialize(resource, comment: nil)
                @resource = resource
                @comment = comment || discussion_class.new
            end

            def discussion_class
                resource.class.lesli_discussions_class
            end

            def discussions
                resource.public_send(
                    resource.class.lesli_discussions_association_name
                )
            end

            def create_path
                helpers.polymorphic_path(
                    [:items, :discussions],
                    discussable_type: resource.class.name,
                    discussable_id: resource.id
                )
            end

            def scope_key
                ActiveSupport::Inflector
                    .underscore(discussion_class.name)
                    .tr("/", "_")
            end
        end
    end
end
