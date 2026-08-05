class Answer < ApplicationRecord
  belongs_to :job_application
  belongs_to :question

  validates :answer, presence: true
  validates :question_id,
            uniqueness: { scope: :job_application_id }

  private

  def question_belongs_to_job
    return unless question && job_application

    if question.job_id != job_application.job_id
      errors.add(:question, 'must belong to the application job')
    end
  end
end
