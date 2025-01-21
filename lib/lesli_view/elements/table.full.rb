module LesliView
    module Element
        class Table < ViewComponent::Base
            attr_reader :id, :class_name, :pagination, :loading, :headless, :columns, :records, :link

            def initialize(id: nil, class_name: "is-striped", pagination: nil, loading: false, headless: false, columns:, records:, link: nil)
                @id = id
                @class_name = class_name
                @pagination = pagination
                @loading = loading
                @headless = headless
                @columns = columns
                @records = records
                @link = link
            end

            def table_header_class(column)
                column[:field] == "id" || column[:align] == "center" ? "has-text-centered" : ""
            end

            def table_body_class(column)
                column[:field] == "id" || column[:align] == "center" ? "has-text-centered" : ""
            end

            def current_sort_dir(column)
                @current_sort_dir ||= {}
                @current_sort_dir[column[:field]] || "asc"
            end

            def toggle_sort_dir(column)
                current_sort_dir(column) == "asc" ? "desc" : "asc"
            end

            def render_head_slot(column)
                content_for?(:"head_#{column[:field]}") ? content_for(:"head_#{column[:field]}") : column[:label]
            end

            def detail_active?(record)
                record[:detail_active]
            end
        end  
    end
end
