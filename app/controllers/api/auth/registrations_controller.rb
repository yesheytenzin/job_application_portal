# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationsController < Devise::RegistrationsController
        # before_action :configure_sign_up_params, only: [:create]
        # before_action :configure_account_update_params, only: [:update]
        include Sanitizers::Auth::AuthSanitizer
        respond_to :json

        def create
          result = Auth::RegistrationService.new(sign_up_params).call

          if result.success?
            sign_in(resource_name, result.resource)
            render json: User::UserSerializer.render(result.resource), status: :created
          else
            render json: { errors: result.errors }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
