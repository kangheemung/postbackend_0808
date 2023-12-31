require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Postbackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.middleware.use ActionDispatch::Cookies
    config.action_controller.default_protect_from_forgery = true
    config.action_controller.forgery_protection_origin_check = false
    # Configuration for the application, engines, and railties goes here.
    config.action_controller.allow_forgery_protection = false
    config.action_controller.log_warning_on_csrf_failure = false
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
