# frozen_string_literal: true

module LesliView
    module Partials
        # Rendering must not consume flash; Core owns that request lifecycle.
        class Notifications < ViewComponent::Base
            CATEGORIES = {
                "info" => "info",
                "notice" => "success",
                "success" => "success",
                "warning" => "warning",
                "alert" => "danger",
                "danger" => "danger",
                "error" => "danger"
            }.freeze

            attr_reader :messages

            def initialize(messages:)
                @messages = messages
            end

            def category_for(type)
                CATEGORIES.fetch(type.to_s, "neutral")
            end
        end
    end
end
