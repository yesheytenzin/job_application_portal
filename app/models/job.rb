class Job < ApplicationRecord
  belongs_to :user
  validates :title, :description, presence: true
  validates :min_salary, :max_salary, presence: true
  has_many_attached :attachments
  validate :allowed_file_types
  validate :allowed_file_size

  def draft?
    status == DRAFT
  end

  def open?
    status == OPEN
  end

  def closed?
    status == CLOSED
  end

  private

  def allowed_file_types
    attachments.each do |attachment|
      next if ALLOWED_TYPES.include?(attachment.content_type)

      errors.add(
        :attachments,
        "#{attachment.filename} has unsupported file type"
      )
    end
  end

  def allowed_file_size
    attachments.each do |attachment|
      next if attachment.blob.byte_size <= MAX_FILE_SIZE

      errors.add(
        :attachments,
        "#{attachment.filename} is larger than 10MB"
      )
    end
  end
end
