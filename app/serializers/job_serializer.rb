# frozen_string_literal: true

class JobSerializer < Blueprinter::Base
  identifier :id
  fields :title, :description, :min_salary, :max_salary, :status

  fields :attachments do |job|
    job.attachments.map do |attachment|
      {
        id: attachment.id,
        filename: attachment.filename.to_s,
        content_type: attachment.content_type
      }
    end
  end
end
