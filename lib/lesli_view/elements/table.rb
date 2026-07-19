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
            attr_reader :id, :class_name, :headless, :columns, :records, :link, :caption, :empty_text

            renders_many :rows, "TableRow"

            def initialize(
                columns: nil,
                records: nil,
                id: nil,
                class_name: nil,
                headless: false,
                link: nil,
                caption: nil,
                empty: nil,
                striped: true,
                compact: false
            )
                @id = id
                @class_name = class_name
                @headless = headless
                @columns = Array(columns).map { |column| column.to_h.symbolize_keys }
                @records = records
                @link = link
                @caption = caption
                @empty_text = empty || I18n.t("lesli_view.table.empty", default: "No records found")
                @striped = striped
                @compact = compact
            end

            def table_classes
                class_names(
                    "lesli-table",
                    ("lesli-table--striped" if @striped),
                    ("lesli-table--compact" if @compact),
                    class_name
                )
            end

            def column_class(column)
                alignment = column[:align]&.to_sym
                alignment = :center if column[:field].to_s == "id"
                return unless %i[left center right].include?(alignment)

                "lesli-table__cell--#{alignment}"
            end

            def value_for(record, column)
                field = column.fetch(:field)
                field_name = field.to_s

                if record.respond_to?(:attributes) && record.attributes.key?(field_name)
                    record.attributes[field_name]
                elsif record.respond_to?(:key?)
                    return record[field] if record.key?(field)
                    return record[field_name] if record.key?(field_name)
                    return record[field_name.to_sym] if record.key?(field_name.to_sym)
                elsif record.respond_to?(field_name)
                    record.public_send(field_name)
                end
            end

            def empty?
                records.present? ? records.empty? : rows.empty?
            end

            class TableRow < ViewComponent::Base
                renders_many :cells, "TableData"

                STATUSES = %w[danger info success warning].freeze

                def initialize(class_name: nil, status: nil)
                    @class_name = class_name
                    @status = status.to_s if STATUSES.include?(status.to_s)
                end

                def call
                    content_tag(
                        :tr,
                        safe_join(cells),
                        class: class_names(@class_name, @status && "lesli-table__row--#{@status}")
                    )
                end

                class TableData < ViewComponent::Base
                    attr_reader :class_name

                    def initialize(class_name: nil, align: nil)
                        @class_name = class_names(
                            class_name,
                            ("lesli-table__cell--#{align}" if %i[left center right].include?(align&.to_sym))
                        )
                    end
                    
                    def call
                        content_tag(:td, content, class: class_name)
                    end
                end
            end
        end
    end
end
