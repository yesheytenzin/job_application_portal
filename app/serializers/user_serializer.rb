# frozen_string_literal: true

class UserSerializer < Blueprinter::Base
  identifier :id
  fields :email, :created_at, :updated_at

  association :role, blueprint: RoleSerializer
  association :profile, blueprint: ProfileSerializer
end
