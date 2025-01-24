=begin
<%= render LesliView::Elements::Tabs.new(active_tab: "tab1") do |tabs| %>
        <% tabs.with_tab(tab_id: "tab1", title: "Tab 1") do  %>
            hola
        <% end %>
        <% tabs.with_tab(tab_id: "tab2", title: "Tab 2") %>
        <% tabs.with_tab(tab_id: "tab3", title: "Tab 3") %>
        <% tabs.with_tab(tab_id: "tab4", title: "Tab 4", icon: "save") %>
        <% tabs.with_tab(tab_id: "tab5", title: "Tab 5", icon: "edit") %>
        <% tabs.with_tab(tab_id: "tab6", title: "Tab 6", icon: "delete") %>
    <% end %>
=end

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

                def initialize(tab_id=nil, title: nil, icon: nil)

                    @tab_id = nil

                    if title 
                        @tab_id = title
                        .downcase                           # string to lowercase
                        .gsub(/[^0-9A-Za-z\s\-\_]/, '')     # remove special characters from string
                        .gsub(/_/, '-')                     # replace underscores with dashes 
                        .gsub(/\s+/, '-')                   # replace spaces or spaces with single dash
                    end

                    if tab_id 
                        @tab_id = tab_id
                    end 

                    @title = title
                    @icon = icon
                end

                def call
                    content_tag :div, content
                end
            end
        end
    end
end
