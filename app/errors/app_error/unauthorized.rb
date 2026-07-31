# frozen_string_literal: true

module AppError
  # Use this for all HTTP 403 errors
  class Unauthorized < BaseError
    def initialize(message = nil, status = :forbidden)
      super I18n.t('access_control.unauthorized'), status
    end
  end
end
