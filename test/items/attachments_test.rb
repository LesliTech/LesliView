require "minitest/autorun"
require "rails/version"
require "action_view"
require "active_model"
require "view_component"
require_relative "../../lib/lesli_view/forms/fields"
require_relative "../../lib/lesli_view/forms/inputs"
require_relative "../../lib/lesli_view/forms/fieldset"
require_relative "../../lib/lesli_view/forms/builder"
require_relative "../../lib/lesli_view/items/attachment"
require_relative "../../lib/lesli_view/items/attachments"

module AttachmentsTestApp
    Blob = Struct.new(:content_type, :byte_size, keyword_init: true)

    class FileProxy
        attr_reader :filename, :blob

        def initialize(filename:, content_type:, byte_size:)
            @filename = filename
            @blob = Blob.new(
                content_type: content_type,
                byte_size: byte_size
            )
        end
    end

    module Items
        class Attachment
            include ActiveModel::Model

            class_attribute :lesli_attachment_content_types,
                default: %w[application/pdf image/png]

            attr_accessor :id, :label, :file

            def persisted?
                id.present?
            end

            def display_name
                label.presence || file.filename.to_s
            end
        end
    end

    class AttachmentAssociation < Array
        def with_attached_file
            self
        end
    end

    class Ticket
        include ActiveModel::Model

        class_attribute :lesli_attachments_class,
            default: Items::Attachment

        attr_accessor :id, :attachments

        def persisted?
            id.present?
        end
    end
end

module LesliView
    module Items
        class AttachmentsTest < Minitest::Test
            def test_renders_upload_form_and_existing_files
                view_context = ActionView::Base.empty
                view_context.define_singleton_method(:protect_against_forgery?) { false }
                view_context.define_singleton_method(:polymorphic_path) do |target, **|
                    target.is_a?(Array) ? "/items/attachments" : "/items/attachments/#{target.id}"
                end

                html = Attachments.new(resource).render_in(view_context)

                assert_includes html, 'enctype="multipart/form-data"'
                assert_includes html, 'action="/items/attachments"'
                assert_includes html, 'accept="application/pdf,image/png"'
                assert_includes html, "Architecture diagram"
                assert_includes html, "application/pdf · 2 KB"
                assert_includes html, "Download"
                assert_includes html, "Remove"
                assert_includes html, 'action="/items/attachments/7"'
                assert_includes html, 'name="_method" value="delete"'
                refute_includes html, "<style>"
            end

            private

            def resource
                attachment = AttachmentsTestApp::Items::Attachment.new(
                    id: 7,
                    label: "Architecture diagram",
                    file: AttachmentsTestApp::FileProxy.new(
                        filename: "architecture.pdf",
                        content_type: "application/pdf",
                        byte_size: 2.kilobytes
                    )
                )

                AttachmentsTestApp::Ticket.new(
                    id: 42,
                    attachments: AttachmentsTestApp::AttachmentAssociation.new(
                        [attachment]
                    )
                )
            end
        end
    end
end
