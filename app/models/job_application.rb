class JobApplication < ApplicationRecord
  include AttachmentValidatable

  STATUSES = [ SUBMITTED, REVIEWED, REJECTED, ACCEPETED ].freeze

  belongs_to :user
  belongs_to :job

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :user_id, uniqueness: { scope: :job_id }

  has_one_attached :resume
  has_one_attached :cover_letter

  validate :validate_resume
  validate :validate_cover_letter

  def submitted?
    status == SUBMITTED
  end

  def reviewed?
    status == REVIEWED
  end

  def rejected?
    status == REJECTED
  end

  def accepted?
    status == ACCEPTED
  end
end
