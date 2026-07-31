# frozen_string_literal: true

module RoleAuthorizable
  extend ActiveSupport::Concern

  private

  def authorize_role(*allowed_roles)
    return if allowed_roles.map(&:to_s).include?(current_user&.role.name)
    raise AppError::ForbiddenError
  end

  def authorize_admin!
    authorize_role(:admin)
  end
end
