# frozen_string_literal: true

module AttachmentSerializer
  private

  def attachment_payload(attachment)
    return unless attachment.attached?

    blob = attachment.blob

    {
      id: blob.id,
      filename: blob.filename.to_s,
      content_type: blob.content_type,
      byte_size: blob.byte_size,
      url: Rails.application.routes.url_helpers.rails_blob_url(blob)
    }
  end

  def attachments_payload(attachments)
    attachments.map do |attachment|
      attachment_payload(attachment)
    end
  end
end
