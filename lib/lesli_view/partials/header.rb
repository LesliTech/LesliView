# frozen_string_literal: true

module LesliView
    module Partials
        # Core resolves routes, selected states and optional engines.
        # Slots carry the host's branding and engine-specific navigation.
        class Header < ViewComponent::Base
            renders_one :logo
            renders_one :navigation

            attr_reader :home_url, :home_label, :actions, :actions_label, :navigation_label

            def initialize(home_url:, home_label:, actions:, actions_label:, navigation_label:)
                @home_url = home_url
                @home_label = home_label
                @actions = actions
                @actions_label = actions_label
                @navigation_label = navigation_label
            end
        end
    end
end
