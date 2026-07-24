# frozen_string_literal: true

module ErrorResponder
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :internal_server_error
    rescue_from ActionController::ParameterMissing, with: :handle_bad_request
    rescue_from ActionController::BadRequest, with: :handle_bad_request
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActionController::RoutingError, with: :handle_not_found
    rescue_from AbstractController::ActionNotFound, with: :handle_not_found
    rescue_from Bundler::Fetcher::AuthenticationForbiddenError, with: :handle_forbidden
  end

  private
  # 400 bad request
  def handle_bad_request(exception)
    render_error(:bad_request, exception.message)
  end
  # 401 unauthorized
  def handle_unauthenticated(exception)
    render_error(:unauthorized, exception.message)
  end
  # 404 not found
  def handle_not_found(exception)
    render_error(:not_found, exception.message)
  end

  def internal_server_error(exception)
    Rails.logger.error '#{exception.class}' "#{exception.message}: \n" + exception.backtrace.first(10).join("\n")
    message = Rails.env.production? ? 'Unexpected error occurred' : exception.message
    render_error(:internal_server_error, exception.message)
  end

  def handle_forbidden(exception)
    render_error(:forbidden, exception.message)
  end
  def render_error(status, message)
    render json: { error: message }, status: status
  end
end
