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
        class Attachment < ViewComponent::Base
            attr_reader :resource

            def initialize(attachment, path: nil)
                @resource = attachment
                @path = path
            end

            def path
                @path || helpers.polymorphic_path(resource)
            end

            def filename
                resource.file.filename.to_s
            end

            def display_name
                resource.respond_to?(:display_name) ? resource.display_name : filename
            end

            def details
                [
                    resource.file.blob.content_type,
                    helpers.number_to_human_size(resource.file.blob.byte_size)
                ].compact.join(" · ")
            end
        end
    end
end
