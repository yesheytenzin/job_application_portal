# frozen_string_literal: true

class JobApplicationSerializer < Blueprinter::Base
  extend AttachmentSerializer
  identifier :id
  fields :status, :user_id, :job_id

  fields :resume do |job_application|
    attachment_payload(job_application.resume)
  end

  fields :cover_letter do |job_application|
    attachment_payload(job_application.cover_letter)
  end
end

# configure environment.rb
# config.default_url_options = { host: 'example.com' }
