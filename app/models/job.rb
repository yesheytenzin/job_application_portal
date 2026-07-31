class Job < ApplicationRecord
  include AttachmentValidatable

  belongs_to :user
  validates :title, :description, presence: true
  validates :min_salary, :max_salary, presence: true
  has_many_attached :attachments
  has_many :job_applications, dependent: :destroy
  validate :validate_attachments

  def draft?
    status == DRAFT
  end

  def open?
    status == OPEN
  end

  def closed?
    status == CLOSED
  end
end
