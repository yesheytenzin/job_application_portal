class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :recoverable :rememberable
  devise :database_authenticatable, :registerable, :validatable
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { within: Devise.password_length }
end
