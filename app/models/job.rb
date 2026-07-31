class Job < ApplicationRecord
  include AttachmentValidatable

  belongs_to :user
  validates :title, :description, presence: true
  validates :min_salary, :max_salary, presence: true
  has_many_attached :attachments
  has_many :job_applications, dependent: :destroy
  validate :validate_attachments

  enum :status, {
    draft: 'draft',
    open: 'open',
    closed: 'closed'
  }
end
