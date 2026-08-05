class JobApplication < ApplicationRecord
  include AttachmentValidatable

  belongs_to :user
  belongs_to :job
  has_many :answers, dependent: :destroy

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :job_id }

  has_one_attached :resume
  has_one_attached :cover_letter

  validate :validate_resume
  validate :validate_cover_letter

  enum :status, {
    submitted: 'submitted',
    reviewed: 'reviewed',
    rejected: 'rejected',
    accepted: 'accepted'
  }
end
