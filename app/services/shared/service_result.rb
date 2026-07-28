# frozen_string_literal: true

module Shared
  class ServiceResult < Struct.new(:success?, :resource, :errors, keyword_init: true)
    def self.success(resource: nil)
      new(success?: true, resource: resource, errors: nil)
    end

    def self.failure(errors:, resource: nil)
      new(success?: false, resource: resource, errors: errors)
    end
  end
end
