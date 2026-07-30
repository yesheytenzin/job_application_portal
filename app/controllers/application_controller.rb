class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include ErrorResponder
  # protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user  ||= warden.authenticate(scope: :user)
  end
end
