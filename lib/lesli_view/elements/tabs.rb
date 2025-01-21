module LesliView
    module Elements
        class Tabs < ViewComponent::Base
            renders_many :tabs, "TabComponent"

            def initialize(active_tab: nil)
                @active_tab = active_tab
            end

            def active?(tab_id)
                tab_id == @active_tab
            end

            class TabComponent < ViewComponent::Base
                attr_reader :tab_id, :title, :icon

                def initialize(tab_id:, title:, icon: nil)
                    @tab_id = tab_id
                    @title = title
                    @icon = icon
                end

                def call
                    content_tag :div, content, { class: "p-5" }
                end
            end
        end
    end
end
