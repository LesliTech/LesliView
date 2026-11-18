# frozen_string_literal: true

module LesliView
    module Partials
        # Core supplies display data and authorized dismissal URLs, never models to query.
        class Announcements < ViewComponent::Base
            ICONS = {
                "info" => "info",
                "success" => "check_circle",
                "warning" => "warning",
                "danger" => "error"
            }.freeze

            attr_reader :announcements, :label, :link_label, :dismiss_label

            def initialize(announcements:, label:, link_label:, dismiss_label:)
                @announcements = announcements
                @label = label
                @link_label = link_label
                @dismiss_label = dismiss_label
            end

            def render?
                announcements.present?
            end

            def category_for(announcement)
                category = announcement.fetch(:category).to_s
                ICONS.key?(category) ? category : "info"
            end
        end
    end
end
