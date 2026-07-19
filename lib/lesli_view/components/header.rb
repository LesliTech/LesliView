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
    module Components
        class Header < ViewComponent::Base
            attr_reader :title, :subtitle, :back, :new_path, :new_label

            def initialize(title, subtitle = nil, new_path: nil, new_label: nil, back: nil)
                # Support the legacy positional options hash:
                # Header.new("Title", back: path)
                if subtitle.is_a?(Hash)
                    legacy_options = subtitle.symbolize_keys
                    subtitle = legacy_options[:subtitle]
                    new_path ||= legacy_options[:new_path]
                    new_label ||= legacy_options[:new_label]
                    back ||= legacy_options[:back]
                end

                @title = title
                @subtitle = subtitle
                @back = back
                @new_path = new_path
                @new_label = new_label
            end

            def back?
                back.present?
            end

            def back_path
                return back unless back == true

                request.referer.presence || "/"
            end

            def new_button_label
                new_label.presence || I18n.t("actions.new", default: "New")
            end

            def actions?
                new_path.present? || content?
            end

            def title_id
                @title_id ||= "lesli-header-title-#{object_id}"
            end
        end
    end
end
