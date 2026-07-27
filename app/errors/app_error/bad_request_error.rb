# frozen_string_literal: true

module AppError
  class BadRequest < BaseError
    def initialize(message = nil, status: :bad_request)
      super I18n.t('errors.bad_request'), status
    end
  end
end
