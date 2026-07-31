module AttachmentValidatable
  extend ActiveSupport::Concern

  RESUME_TYPES = [
    'application/pdf'
  ].freeze

  COVER_LETTER_TYPES = [
    'application/pdf'
  ].freeze

  ATTACHMENT_TYPES = [
    'application/pdf'
  ].freeze

  RESUME_MAX_SIZE = 2.megabytes
  COVER_LETTER_MAX_SIZE = 3.megabytes
  ATTACHMENT_MAX_SIZE = 10.megabytes

  private

  def validate_resume
    validate_file(
      resume,
      :resume,
      RESUME_TYPES,
      RESUME_MAX_SIZE
    )
  end

  def validate_cover_letter
    validate_file(
      cover_letter,
      :cover_letter,
      COVER_LETTER_TYPES,
      COVER_LETTER_MAX_SIZE
    )
  end

  def validate_attachments
    attachments.each do |file|
      validate_file(
        file,
        :attachments,
        ATTACHMENT_TYPES,
        ATTACHMENT_MAX_SIZE
      )
    end
  end

  def validate_file(file, attribute, allowed_types, max_size)
    return unless file.present?

    attachment = file.respond_to?(:blob) ? file.blob : file

    unless allowed_types.include?(attachment.content_type)
      errors.add(
        attribute,
        "#{attachment.filename} type is not allowed"
      )
    end

    if attachment.byte_size > max_size
      errors.add(
        attribute,
        "#{attachment.filename} exceeds #{max_size / 1.megabyte}MB"
      )
    end
  end
end
