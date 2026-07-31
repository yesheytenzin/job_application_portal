# frozen_string_literal: true

class JobApplicationSerializer < Blueprinter::Base
  identifier :id
  fields :status, :user_id, :job_id

  fields :resume do |job_application|
    attached_payload(job_application.resume)
  end

  fields :cover_letter do |job_application|
    attached_payload(job_application.cover_letter)
  end

  private

  def attached_payload(attachment)
    return unless attachment.attached?
    blob = attachment.blob

    {
      id: blob.id,
      filename: blob.filename.to_s,
      content_type: blob.content_type,
      url: Rails.application.routes.url_helpers.rails_blob_url(blob)
    }
  end
end

# configure environment.rb
# config.default_url_options = { host: 'example.com' }
