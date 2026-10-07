# frozen_string_literal: true

module Api
  module Guard
    class SessionsController < Devise::SessionsController
      include Sanitizers::Auth::AuthSanitizer

      respond_to :json

      def create
        result = ::Guard::SessionService.new(sign_in_params).call

        if result.success?
          user = result.value!
          sign_in(resource_name, user)
          render json: User::UserSerializer.render(user), status: :ok
        else
          render json: { errors: result.failure }, status: :unauthorized
        end
      end

      def destroy
        sign_out(resource_name)
        render json: { message: 'Successfully logged out' }, status: :ok
      end
    end
  end
end
