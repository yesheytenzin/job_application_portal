# frozen_string_literal: true

class Api::V1::Auth::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include Sanitizers::Auth::AuthSanitizer
  respond_to :json

  def create
    result = Api::V1::Auth::SessionService.new(sign_in_params).call

    if result.success?
      sign_in(resource_name, result.resource)
      render json: User::UserSerializer.render(result.resource), status: :ok
    else
      render json: { errors: result.errors }, status: :unauthorized
    end
  end

  def destroy
    sign_out(resource_name)
    render json: { message: 'Successfully logged out' }, status: :ok
  end
end
