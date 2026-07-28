# frozen_string_literal: true

module Sanitizers
  module Auth
    module AuthSanitizer
      private
      def sign_up_params
        params.expect(user: [ :email, :password, :password_confirmation])
      end

      def sign_in_params
        params.expect(user: [ :email, :password ])
      end
    end
  end
end
