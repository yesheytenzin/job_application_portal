# frozen_string_literal: true

module AppError
  class AuthenticationFailed < BaseError
    def initialize(message = nil, status = :unauthorized)
      super I18n.t('access_control.authentication_failed', error: message), status
    end
  end
end
