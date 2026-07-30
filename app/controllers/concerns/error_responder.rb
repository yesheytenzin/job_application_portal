# frozen_string_literal: true

module ErrorResponder
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :internal_server_error

    rescue_from AppError::Unauthenticated, with: :handle_unauthenticated
    rescue_from AppError::Unauthorized, with: :hanlde_unauthorized
    rescue_from AppError::AuthenticationFailed, with: :handle_unauthenticated
    rescue_from AppError::RequestFailed, with: :handle_unauthorized

    rescue_from ActionController::ParameterMissing, with: :handle_bad_request
    rescue_from ActionController::BadRequest, with: :handle_bad_request
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActionController::RoutingError, with: :handle_not_found
    rescue_from AbstractController::ActionNotFound, with: :handle_not_found
    rescue_from Bundler::Fetcher::AuthenticationForbiddenError, with: :handle_forbidden
  end

  private

  def handle_bad_request(exception)
    render_error(:bad_request, exception.message)
  end

  def handle_unauthenticated(exception)
    render_error(:unauthorized, exception.message)
  end

  def hanlde_unauthorized(exception)
    render_error(:unauthorized, exception.message)
  end

  def handle_not_found(exception)
    render_error(:not_found, exception.message)
  end

  def internal_server_error(exception)
    Rails.logger.error("#{exception.class}: #{exception.message}")
    Rails.logger.error(exception.backtrace.join("\n"))
    render_error(:internal_server_error, "#{exception.message}")
  end

  def handle_forbidden(exception)
    render_error(:forbidden, exception.message)
  end

  def render_error(status, message)
    render json: { error: message }, status: status
  end
end
