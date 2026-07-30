class JobApplication < ApplicationRecord
  include AttachmentValidatable

  STATUSES = [ SUBMITTED, REVIEWED, REJECTED, ACCEPETED ].freeze

  belongs_to :user
  belongs_to :job

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :user_id, uniqueness: { scope: :job_id }

  has_one_attached :resume
  has_one_attached :cover_letter

  validate :resume_type
  validate :resume_size
  validate :cover_type
  validate :cover_size

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

  private
  def resume_type
    validate_attachment_types(:resume)
  end

  def cover_type
    validate_attachment_types(:cover_letter)
  end

  def resume_size
    validate_attachment_sizes(:resume)
  end

  def cover_size
    validate_attachment_sizes(:cover_letter)
  end
end
