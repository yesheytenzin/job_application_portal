# frozen_string_literal: true

module AppError
  class UnauthorizedError < BaseError
    def initialize(message = I18n.t('errors.unauthorized'), status: :unauthorized)
      super message, status
    end
  end
end
