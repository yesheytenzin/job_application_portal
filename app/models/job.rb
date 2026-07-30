class Job < ApplicationRecord
  include AttachmentValidatable

  belongs_to :user
  validates :title, :description, presence: true
  validates :min_salary, :max_salary, presence: true
  has_many_attached :attachments
  validate :attachment_file_type
  validate :attachment_file_size
  has_many :job_applications, dependent: :destroy

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
  def attachment_file_type
    validate_attachment_types(:attachments)
  end

  def attachment_file_size
    validate_attachment_sizes(:attachments)
  end
end
