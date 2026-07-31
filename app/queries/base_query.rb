# frozen_string_literal: true

class BaseQuery
  attr_reader :params, :current_user

  def initialize(params: {}, current_user: nil)
    @params = params
    @current_user = current_user
  end

  def query
    raise NotImplementedError, "#{self.class} must implement  #query"
  end
end
