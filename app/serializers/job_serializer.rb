# frozen_string_literal: true

class JobSerializer < Blueprinter::Base
  identifier :id
  fields :title, :description, :min_salary, :max_salary, :status
end
