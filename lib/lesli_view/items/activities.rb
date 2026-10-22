=begin

Lesli

Copyright (c) 2025, Lesli Technologies, S. A.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.

Lesli · Ruby on Rails SaaS Development Framework.

Made with ♥ by LesliTech
Building a better future, one line of code at a time.

@contact  hello@lesli.tech
@website  https://www.lesli.tech
@license  GPLv3 http://www.gnu.org/licenses/gpl-3.0.en.html

// · ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~
// · 
=end
module LesliView
    module Items
        class Activities < ViewComponent::Base
            DEFAULT_LIMIT = 25
            I18N_SCOPE = "lesli.items.activities"
            DATE_FORMAT = "%Y-%m-%d · %H:%M"

            attr_reader :activities, :empty_text, :icons, :i18n_scope

            def initialize(
                resource,
                icons: {},
                i18n_scope: I18N_SCOPE,
                limit: DEFAULT_LIMIT,
                empty_text: nil
            )
                @icons = icons
                @i18n_scope = i18n_scope
                @activities = activity_scope(resource, limit).map do |activity|
                    activity_to_timeline(activity)
                end
                @empty_text = empty_text || I18n.t(
                    "#{i18n_scope}.empty",
                    default: "No activities have been recorded yet."
                )
            end

            private

            def activity_to_timeline(activity)
                metadata = activity.metadata.is_a?(Hash) ? activity.metadata : {}

                {
                    "actor" => actor_name(activity.actor),
                    "date" => I18n.l(activity.created_at, format: DATE_FORMAT),
                    "description" => activity_description(activity, metadata),
                    "icon" => activity.activity_code.to_s,
                    "operation" => activity_operation(activity)
                }
            end

            def activity_description(activity, metadata)
                I18n.t(
                    "#{activity_i18n_key(activity)}.#{description_key(metadata)}",
                    from: snapshot_name(metadata_value(metadata, :from)),
                    to: snapshot_name(metadata_value(metadata, :to)),
                    default: activity.description.to_s
                ).presence
            end

            def activity_i18n_key(activity)
                "#{i18n_scope}.events.#{activity.activity_code}"
            end

            def activity_operation(activity)
                I18n.t(
                    "#{activity_i18n_key(activity)}.operation",
                    default: activity.activity_code.to_s.humanize
                )
            end

            def activity_scope(resource, limit)
                resource.activities
                    .includes(:actor)
                    .reorder(created_at: :desc, id: :desc)
                    .limit(normalize_limit(limit))
            end

            def actor_name(actor)
                full_name = actor.full_name if actor.respond_to?(:full_name)
                name = actor.name if actor.respond_to?(:name)

                full_name.presence || name.presence || I18n.t(
                    "#{i18n_scope}.unknown_actor",
                    default: "Unknown user"
                )
            end

            def description_key(metadata)
                has_change = metadata.key?(:from) || metadata.key?("from") ||
                    metadata.key?(:to) || metadata.key?("to")

                return "description" unless has_change
                return "set" if metadata_value(metadata, :from).nil?
                return "removed" if metadata_value(metadata, :to).nil?

                "changed"
            end

            def metadata_value(metadata, key)
                return metadata[key] if metadata.key?(key)

                metadata[key.to_s]
            end

            def normalize_limit(limit)
                normalized_limit = Integer(limit)
                return normalized_limit if normalized_limit.positive?

                raise ArgumentError, "limit must be a positive integer"
            rescue TypeError, ArgumentError
                raise ArgumentError, "limit must be a positive integer"
            end

            def snapshot_name(snapshot)
                return "" if snapshot.nil?
                return snapshot.to_s unless snapshot.is_a?(Hash)

                [:name, :subject, :uid, :id].each do |key|
                    value = metadata_value(snapshot, key)
                    return value.to_s if value.present?
                end

                ""
            end
        end
    end
end
