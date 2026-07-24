# frozen_string_literal: true

module Sanitizers
  module Users
    class UserParamsSanitizer
      def initialize(params)
        @params = params
      end

      def sign_up_params
        @params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def sign_in_params
        @params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
