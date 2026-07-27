# frozen_string_literal: true

module AppError
  class BadRequestError < BaseError
    def initialize(message = I18n.t('errors.bad_request'), status: :bad_request)
      super message, status
    end
  end
end
