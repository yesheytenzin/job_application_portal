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
  end

  private
  # 400 bad request
  def handle_bad_request(exception)
    render(status: :bad_request, message: exception.message)
  end
  # 401 unauthorized
  def handle_unauthenticated(exception)
    render(status: :unauthorized, message: exception.message || "you must login first")
  end
  # 404 not found
  def handle_not_found(exception)
    render json: { status: :not_found, message: "The request could not be found." }
  end

  def internal_server_error(exception)
    Rails.logger.error "#{exception.class}" "#{exception.message}: \n" + exception.backtrace.first(10).join("\n")
    message = Rails.env.production? ? "Unexpected error occurred" : exception.message
    render(status: :internal_server_error, message: message)
  end
end
