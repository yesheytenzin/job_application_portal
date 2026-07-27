class Role < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  ADMIN = 'admin'
  APPLICANT = 'applicant'

  scope :admin, -> { find_by(name: ADMIN) }
  scope :applicant, -> { find_by(name: APPLICANT) }
end
