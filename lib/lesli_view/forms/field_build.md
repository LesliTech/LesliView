<%= form.field_build do %>
        <div class="buttons">
            <%= render(LesliView::Elements::Button.new("Copy link", icon:"link", small:true)) %>
            <%= render(LesliView::Elements::Button.new("Copy link", icon:"link", small:true)) %>
            <%= render(LesliView::Elements::Button.new("Need translation", icon:"translate", small:true, solid:true, warning:true)) %>
        </div>
    <% end %>
