# frozen_string_literal: true

module AppError
  # Use this for all HTTP 401 errors
  class Unauthenticated < BaseError
    def initialize(message = nil, status = :unauthorized)
      super(message || I18n.t('access_control.unauthenticated'), status)
    end
  end
end
