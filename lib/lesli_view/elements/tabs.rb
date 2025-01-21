module LesliView
    module Elements
        class Tabs < ViewComponent::Base
            renders_many :tabs, "LesliView::Elements::TabComponent"

            def initialize(active_tab: nil)
                @active_tab = active_tab
            end

            def active?(tab_id)
                tab_id == @active_tab
            end
        end

        class TabComponent < ViewComponent::Base
            attr_reader :tab_id, :title, :content, :icon

            def initialize(tab_id:, title:, content:, icon: nil)
                @tab_id = tab_id
                @title = title
                @content = content
                @icon = icon
            end
        end          
    end
end
