# frozen_string_literal: true

module AppError
  class NotFound < BaseError
    def initialize(message = nil, status: :not_found)
      super I18n.t('errors.not_found'), status
    end
  end
end
