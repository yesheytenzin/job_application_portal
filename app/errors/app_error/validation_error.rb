# frozen_string_literal: true

module AppError
  class ValidationError < BaseError
    def initialize(message = nil, status: :unprocessable_entity)
      super I18n.t('errors.validation_error'), status
    end
  end
end
