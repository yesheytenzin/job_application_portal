# frozen_string_literal: true

class Api::V1::Auth::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  include Sanitizers::Auth::AuthSanitizer
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.role = Role.applicant
    resource.save

    if resource.persisted?
      sign_in(resource_name, resource)
      render json: {
        message: 'Signed up successfully and logged in',
        user: JSON.parse(User::UserSerializer.render(resource))
      }, status: :created
    else
      clean_up_passwords(resource)
      render json: {
        errors: resource.errors.as_json
      }, status: :unprocessable_entity
    end
  end
end
