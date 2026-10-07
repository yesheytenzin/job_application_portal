# frozen_string_literal: true

class JobSerializer < Blueprinter::Base
  include AttachmentSerializer
  identifier :id
  fields :title, :description, :min_salary, :max_salary, :status

  fields :attachments do |job|
    attachments_payload(job.attachments)
  end
end
