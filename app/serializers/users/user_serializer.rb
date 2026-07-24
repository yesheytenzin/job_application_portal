# frozen_string_literal: true

class UserSerializer < Blueprinter::Base
  identifier :id
  fields :email, :created_at, :updated_at
end
