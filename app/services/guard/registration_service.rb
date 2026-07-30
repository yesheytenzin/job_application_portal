# frozen_string_literal: true

module Guard
  class RegistrationService < BaseService
    def initialize(sign_up_params)
      @sign_up_params = sign_up_params
    end

    def call
      resource = build_resource
      if resource.save
        success(resource)
      else
        failure(resource.errors.as_json)
      end
    end

    private

    attr_reader :sign_up_params
    def build_resource
      resource = User.new(sign_up_params)
      resource.role = Role.find_or_create_by!(name: :applicant)
      resource
    end
  end
end
