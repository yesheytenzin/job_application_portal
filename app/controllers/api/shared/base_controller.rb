# frozen_string_literal: true

module Api
  module Shared
    class BaseController < ApplicationController
      before_action :authenticate_user!
    end
  end
end
