# frozen_string_literal: true


def json
  result = JSON.parse(response.body)
  result.is_a?(Array) ? result : ActiveSupport::HashWithIndifferentAccess.new(result)
end

def headers
  { 'Content-Type' => 'application/json' }
end
