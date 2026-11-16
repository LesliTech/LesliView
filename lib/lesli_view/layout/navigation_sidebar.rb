# frozen_string_literal: true

module LesliView
    module Layout
        # Page-level navigation: sticky on desktop, native disclosure on mobile.
        # Callers own translations, routes, authorization, and selected state.
        class NavigationSidebar < ViewComponent::Base
            attr_reader :items, :label

            # Each item has :label, :path, :selected, and optional :count and :icon (a Remix Icon CSS class).
            # empty_selection_label describes pages without a selected item.
            def initialize(items:, label:, empty_selection_label: nil)
                @items = items
                @label = label
                @empty_selection_label = empty_selection_label
            end

            def selected_label
                selected = items.find { |item| item[:selected] }
                selected ? selected.fetch(:label) : (@empty_selection_label || label)
            end
        end
    end
end
