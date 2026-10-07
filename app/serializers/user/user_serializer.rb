# frozen_string_literal: true

class User::UserSerializer < Blueprinter::Base
  identifier :id
  fields :email, :created_at, :updated_at

  association :role, blueprint: RoleSerializer
end
