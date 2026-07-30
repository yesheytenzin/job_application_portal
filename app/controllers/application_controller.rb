class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include ErrorResponder
  # protect_from_forgery with: :exception
end
