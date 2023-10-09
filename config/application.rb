require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ibcx
  class Application < Rails::Application
    config.autoload_paths << "#{root}/app/views"
    config.autoload_paths << "#{root}/app/views/layouts"
    config.autoload_paths << "#{root}/app/views/components"

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.hosts << '.test'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    #
    config.rails_semantic_logger.quiet_assets = true

    # 404 catch all route
    config.after_initialize do |app|
      # must reload routes or doesn't work in Rails.env.development?
      Rails.application.reload_routes!

      app.routes.append do
        match "*bad_routes", :to => "application#not_found", :via => :all
      end
    end

  end
end
