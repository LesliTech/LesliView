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
        class Attachments < ViewComponent::Base
            attr_reader :resource, :attachment

            def initialize(
                resource,
                attachment: nil,
                path_to_create: nil,
                path_to_update: nil
            )
                @resource = resource
                @path_to_create = path_to_create
                @path_to_update = path_to_update
                @attachment = attachment || attachment_class.new
            end

            def attachment_class
                resource.class.lesli_attachments_class
            end

            def attachments
                resource.attachments.with_attached_file
            end

            def create_path
                @path_to_create || helpers.polymorphic_path(
                    [:items, :attachments],
                    attachable_type: resource.class.name,
                    attachable_id: resource.id
                )
            end

            def attachment_path(item)
                return @path_to_update.call(item) if @path_to_update.respond_to?(:call)

                helpers.polymorphic_path(item)
            end

            def scope_key
                ActiveSupport::Inflector.underscore(attachment_class.name).tr("/", "_")
            end

            def accepted_content_types
                attachment_class.lesli_attachment_content_types.join(",")
            end
        end
    end
end
