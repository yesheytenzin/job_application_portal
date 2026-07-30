# frozen_string_literal: true

class JobApplicationSerializer < Blueprinter::Base
  identifier :id
  fields :status, :user_id, :job_id

  fields :resume do |job_application|
    next unless job_application.resume.attached?
    {
      id: job_application.resume.id,
      filename: job_application.resume.filename.to_s,
      content_type: job_application.resume.content_type
    }
  end

  fields :cover_letter do |job_application|
    next unless job_application.cover_letter.attached?
    {
      id: job_application.cover_letter.id,
      filename: job_application.cover_letter.filename.to_s,
      content_type: job_application.cover_letter.content_type
    }
  end
end
