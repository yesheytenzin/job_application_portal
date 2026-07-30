# frozen_string_literal: true

module AppError
  class RequestFailed < BaseError
    def initialize(message = nil, status = :unauthorized)
      super I18n.t('access_control.request_failed', error: message), status
    end
  end
end
