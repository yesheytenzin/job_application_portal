class Profile < ApplicationRecord
  belongs_to :user
  validates :first_name, :last_name, presence: true
  validates :phone, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :address, presence: true
end
