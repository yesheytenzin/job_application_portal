# frozen_string_literal: true

module Api
  module Guard
    class RegistrationsController < Devise::RegistrationsController
      include Sanitizers::Auth::AuthSanitizer

      respond_to :json

      def create
        result = ::Guard::RegistrationService.new(sign_up_params).call

        if result.success?
          user = result.value!
          sign_in(resource_name, user)
          render json: User::UserSerializer.render(user), status: :created
        else
          render json: { errors: result.failure }, status: :unprocessable_entity
        end
      end
    end
  end
end
