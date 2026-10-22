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
        class Discussion < ViewComponent::Base
            attr_reader :discussion

            def initialize(discussion)
                @discussion = discussion
            end

            def author_name
                author = discussion.author
                full_name = author.full_name if author.respond_to?(:full_name)
                name = author.name if author.respond_to?(:name)

                full_name.presence || name.presence || I18n.t(
                    "lesli.items.discussions.unknown_author",
                    default: "Unknown user"
                )
            end

            def created_at_label
                return if discussion.created_at.blank?

                I18n.l(
                    discussion.created_at,
                    format: "%Y-%m-%d · %H:%M"
                )
            end

            def created_at_iso8601
                return if discussion.created_at.blank?

                discussion.created_at.strftime("%Y-%m-%dT%H:%M:%S%:z")
            end
        end
    end
end
