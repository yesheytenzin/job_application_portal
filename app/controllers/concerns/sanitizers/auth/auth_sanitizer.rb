# frozen_string_literal: true

module Sanitizers
  module Auth
    module AuthSanitizer
      private
      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
