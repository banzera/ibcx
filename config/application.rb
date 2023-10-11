require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ibcx
  class Application < Rails::Application

    # Load Phlex resources
    config.autoload_paths << "#{root}/app/views"
    config.autoload_paths << "#{root}/app/views/layouts"
    config.autoload_paths << "#{root}/app/views/components"

    config.force_ssl = true
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_record.encryption.primary_key         = Rails.application.credentials[Rails.env.to_sym][:active_record_encryption][:primary_key]
    config.active_record.encryption.deterministic_key   = Rails.application.credentials[Rails.env.to_sym][:active_record_encryption][:deterministic_key]
    config.active_record.encryption.key_derivation_salt = Rails.application.credentials[Rails.env.to_sym][:active_record_encryption][:key_derivation_salt]
  end
end
