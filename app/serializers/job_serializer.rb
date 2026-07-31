# frozen_string_literal: true

class JobSerializer < Blueprinter::Base
  identifier :id
  fields :title, :description, :min_salary, :max_salary, :status

  fields :attachments do |job|
    job.attachments.map do |attachment|
      {
        id: attachment.id,
        filename: attachment.filename.to_s,
        content_type: attachment.blob.content_type,
        byte_size: attachment.blob.byte_size,
        url: Rails.application.routes.url_helpers.rails_blob_url(
          attachment,
          host: 'localhost:3000'
        )
      }
    end
  end
end
