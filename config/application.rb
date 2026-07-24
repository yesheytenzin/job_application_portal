require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module JobApplicationPortal
  class Application < Rails::Application
    config.load_defaults 8.1
    config.api_only = true

    # browser level cookies management
    config.middleware.use ActionDispatch::Cookies

    # configure session via cookies
    config.middleware.use ActionDispatch::Session::CookieStore,
                          key: "_job_application_portal_session",
                          secure: Rails.env.production?,
                          httponly: true
  end
end
