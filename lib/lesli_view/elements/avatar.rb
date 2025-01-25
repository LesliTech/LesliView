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
        class Avatar < ViewComponent::Base
            attr_reader :image, :name, :size, :letter, :font_size, :avatar_style

            def initialize(image: nil, name: "", size: "medium")
                @image = image
                @name = name
                @size = size
                @letter = ""
                @font_size = ""
                @avatar_style = ""
                calculate_size
                get_letter unless @image
            end

            private

            # Calculate the size of the avatar and set styles accordingly
            def calculate_size
                case size
                when "small"
                    @font_size = "is-size-5"
                    @avatar_style = "height: 60px; width: 60px;"
                when "medium"
                    @font_size = "is-size-3"
                    @avatar_style = "height: 120px; width: 120px;"
                when "large"
                    @font_size = "is-size-1"
                    @avatar_style = "height: 180px; width: 180px;"
                else
                    raise ArgumentError, "Invalid size: #{size}"
                end
            end

            # Calculate the initials based on the name
            def get_letter
                return @letter = "" if name.strip.empty?

                words = name.strip.split(/\s+/)
                @letter = words.first(2).map { |word| word[0].upcase }.join
            end
        end
    end
end
