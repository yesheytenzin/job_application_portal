module AttachmentValidatable
  extend ActiveSupport::Concern

  private

  def validate_attachment_types(name)
    normalized_attachments(name).each do |attachment|
      errors.add(name, "#{attachment.filename} has unsupported file type") unless
        ALLOWED_DOC_TYPES.include?(attachment.content_type)
    end
  end

  def validate_attachment_sizes(name)
    normalized_attachments(name).each do |attachment|
      errors.add(name, "#{attachment.filename} is larger than 10MB") if
        attachment.blob.byte_size > MAX_FILE_SIZE
    end
  end

  def normalized_attachments(name)
    attachment = public_send(name)
    return [] unless attachment.attached?

    attachment.respond_to?(:attachments) ? attachment.attachments : [ attachment ]
  end
end
