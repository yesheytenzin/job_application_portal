# frozen_string_literal: true

module AppError
  class Forbidden < BaseError
    def initialize(message = nil, status: :forbidden)
      super I18n.t('errors.forbidden'), status
    end
  end
end
