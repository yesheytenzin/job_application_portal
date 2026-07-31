# frozen_string_literal: true

module Api
  module User
    module V1
      class BaseController < ApplicationController
        before_action :authenticate_user!
      end
    end
  end
end
