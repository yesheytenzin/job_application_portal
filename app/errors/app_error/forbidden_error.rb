# frozen_string_literal: true

module AppError
  class ForbiddenError < BaseError
    def initialize(message = I18n.t('errors.forbidden'), status: :forbidden)
      super message, status
    end
  end
end
