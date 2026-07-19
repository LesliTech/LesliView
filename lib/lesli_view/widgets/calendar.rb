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
        class Calendar < ViewComponent::Base
            WEEK_STARTS = {
                sunday: 0,
                monday: 1
            }.freeze

            attr_reader :title, :number, :date, :selected_date, :week_starts_on

            def initialize(
                title = nil,
                number = nil,
                date: ::Date.current,
                events: [],
                selected_date: ::Date.current,
                week_starts_on: :sunday
            )
                @title = title
                @number = number # Retained for compatibility with the original positional API.
                @date = normalize_date(date) || ::Date.current
                @selected_date = normalize_date(selected_date)
                @week_starts_on = normalize_week_start(week_starts_on)
                @event_dates = Array(events).each_with_object({}) do |event, dates|
                    event_date = normalize_date(event)
                    dates[event_date] = true if event_date
                end
            end

            def calendar_title
                title.presence || I18n.l(date, format: "%B %Y")
            end

            def weekdays
                abbreviated = Array(I18n.t("date.abbr_day_names"))
                full = Array(I18n.t("date.day_names"))
                offset = WEEK_STARTS.fetch(week_starts_on)

                abbreviated.zip(full).rotate(offset)
            end

            def calendar_days
                first_day = date.beginning_of_month
                leading_blanks = (first_day.wday - WEEK_STARTS.fetch(week_starts_on)) % 7
                days = Array.new(leading_blanks) + (1..date.end_of_month.day).to_a
                days.concat(Array.new((7 - (days.length % 7)) % 7))
            end

            def date_for(day)
                date.change(day: day)
            end

            def selected?(day)
                selected_date == date_for(day)
            end

            def today?(day)
                ::Date.current == date_for(day)
            end

            def event?(day)
                @event_dates.key?(date_for(day))
            end

            private

            def normalize_date(value)
                return if value.nil?
                return value.to_date if value.respond_to?(:to_date)

                ::Date.parse(value.to_s)
            rescue ArgumentError, TypeError
                nil
            end

            def normalize_week_start(value)
                value = value.to_s.downcase.to_sym
                return value if WEEK_STARTS.key?(value)

                :sunday
            end
        end
    end
end
