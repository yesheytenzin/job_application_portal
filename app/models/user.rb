class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :recoverable :rememberable
  devise :database_authenticatable, :registerable, :validatable
  belongs_to :role
  has_one :profile, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { within: Devise.password_length }
  validates :role, presence: true

  def admin?
    role.name == ADMIN
  end

  def applicant?
    role.name == APPLICANT
  end
end
