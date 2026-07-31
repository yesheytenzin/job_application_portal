# frozen_string_literal: true

module Api
  module Job
    module V1
      class BaseController < ApplicationController
        # before_action :authenticate_user!
        # skip_before_action :check_admin!

        #   private
        #
        #   def check_admin!
        #     return if current_user.admin?
        #     render json: { error: 'Access denied: Admin privileges required' }, status: :forbidden
        #   end
      end
    end
  end
end
