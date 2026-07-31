# frozen_string_literal: true

class BaseService
  include Dry::Monads[:result]

  private

  def success(value = nil)
    Success(value)
  end

  def failure(error)
    Failure(error)
  end
end
