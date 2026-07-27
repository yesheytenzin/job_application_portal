# frozen_string_literal: true

module AppError
  class UnauthorizedError < BaseError
    def initialize(message = nil, status: :unauthorized)
      super I18n.t('errors.unauthorized'), status
    end
  end
end
