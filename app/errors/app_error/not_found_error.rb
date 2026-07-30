# frozen_string_literal: true

module AppError
  class NotFoundError < BaseError
    def initialize(message = I18n.t('errors.not_found'), status: :not_found)
      super message, status
    end
  end
end
