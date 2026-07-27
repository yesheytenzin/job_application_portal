# frozen_string_literal: true

module RoleAuthorizable
  extend ActiveSupport::Concern

  private

  def render_error(status, message)
    render json: { error: message }, status: status
  end
  def authorize_role(*allowed_roles)
    unless allowed_roles.map(&:to_s).include?(current_user&.role_name)
      render_error(:forbidden, I18n.t('errors.not_authorized'))
    end
  end

  def authotize_admin!
    authorize_role!(:admin)
  end
end
