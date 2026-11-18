# frozen_string_literal: true

module LesliView
    module Partials
        # Presentation only: the caller owns HTTP status, authorization and error data.
        class Error < ViewComponent::Base
            renders_one :illustration
            renders_one :details

            attr_reader :title, :message, :tone, :id

            def initialize(title:, message:, id: nil, tone: :default)
                @title = title
                @message = message
                @tone = tone
                @id = id || "lesli-error-#{object_id}"
            end

            def title_id
                "#{id}-title"
            end
        end
    end
end
