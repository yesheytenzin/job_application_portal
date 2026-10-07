# frozen_string_literal: true

module Api
  module Guard
    class RegistrationsController < Devise::RegistrationsController
      include Sanitizers::Auth::AuthSanitizer
      respond_to :json

      def create
        build_resource(sign_up_params)

        resource.save
        if resource.persisted?
          sign_in(resource_name, resource)
          render json: {
            message: 'Signed up successfully and logged in',
            user: {
              id: resource.id,
              email: resource.email
            }
          }, status: :created
        else
          clean_up_passwords(resource)
          render json: {
            errors: resource.errors.as_json
          }, status: :unprocessable_entity
        end
      end
    end
  end
end
