# frozen_string_literal: true

module ErrorResponder
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :internal_server_error
    rescue_from ActionController::ParameterMissing, with: :handle_bad_request
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from BaseError, with: :handle_base_error
  end

  private

  def handle_bad_request(exception)
    render json: AppError::BadRequestError.new(exception.message).to_h, status: :bad_request
  end

  def handle_not_found(exception)
    render json: AppError::NotFoundError.new(exception.message).to_h, status: :not_found
  end

  def internal_server_error(exception)
    Rails.logger.error "#{exception.class}" "#{exception.message}: \n" + exception.backtrace.first(10).join("\n")
    message = Rails.env.production? ? 'Unexpected error occurred' : exception.message
    render_error(:internal_server_error, message)
  end

  def handle_base_error(exception)
    render json: exception.to_h, status: exception.status
  end

  def render_error(status, message)
    render json: { error: message }, status: status
  end
end
