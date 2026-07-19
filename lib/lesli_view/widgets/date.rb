# frozen_string_literal: true

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
    module Widgets
        class Date < ViewComponent::Base
            attr_reader :date

            def initialize(date = Time.current)
                @date = normalize_date(date) || ::Date.current
            end

            def month_name
                I18n.l(date, format: "%B")
            end

            def weekday_name
                I18n.l(date, format: "%A")
            end

            def accessible_date
                I18n.l(date, format: :long)
            end

            private

            def normalize_date(value)
                return if value.nil?
                return value.to_date if value.respond_to?(:to_date)

                ::Date.parse(value.to_s)
            rescue ArgumentError, TypeError
                nil
            end
        end
    end
end
