class Job < ApplicationRecord
  belongs_to :user
  validates :title, :description, presence: true
  validates :min_salary, :max_salary, presence: true

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
