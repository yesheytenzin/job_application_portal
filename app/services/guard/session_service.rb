# frozen_string_literal: true

module Guard
  class SessionService < BaseService
    def initialize(sign_in_params)
      @sign_in_params = sign_in_params
    end

    def call
      user = User.find_by(email: sign_in_params[:email])
      return failure([ 'Invalid email or password' ]) unless user

      if user.valid_password?(sign_in_params[:password])
        success(user)
      else
        failure([ 'Invalid email or password' ])
      end
    end

    private

    attr_reader :sign_in_params
  end
end
