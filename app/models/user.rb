class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :recoverable :rememberable
  devise :database_authenticatable, :registerable, :validatable
  belongs_to :role
  validates :role, presence: true
  has_one :profile, dependent: :destroy
  has_many :jobs, dependent: :destroy

  def admin?
    role.name == ADMIN
  end

  def applicant?
    role.name == APPLICANT
  end
end
