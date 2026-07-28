# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionService
        def initialize(sign_in_params)
          @sign_in_params = sign_in_params
        end

        def call
          user = User.find_by(email: sign_in_params[:email])
          if user.nil?
            return Shared::ServiceResult.failure(errors: [ 'Invalid email or password' ])
          end

          if user.valid_password?(sign_in_params[:password])
            Shared::ServiceResult.success(resource: user)
          else
            Shared::ServiceResult.failure(errors: [ 'Invalid email or password' ])
          end
        end

        private

        attr_reader :sign_in_params
      end
    end
  end
end
