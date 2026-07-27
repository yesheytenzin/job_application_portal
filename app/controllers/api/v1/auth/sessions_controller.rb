# frozen_string_literal: true

class Api::V1::Auth::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: User::UserSerializer.render(resource)
  end

  def destroy
    sign_out(resource_name)
    render json: {
      message: 'Successfully logged out'
    }, status: :ok
  end
end
