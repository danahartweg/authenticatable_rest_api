require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

# Adding additional devise dependencies
# Change inheritance to ActionController::API after you remove the login page
# class ApplicationController < ActionController::API
#   # # Temporary addition of layout rendering engine
#   # # include AbstractController::Layouts

#   # # Include this line to enable Flash messages for all pages
#   include ActionController::Flash

#   # # Can be removed when api login page is removed
#   # include AbstractController::Layouts
#   # # include AbstractController::AssetPaths

#   # include AbstractController::Helpers
#   # include ActionController::Helpers



#   # # include ActionController::Caching
#   include ActionController::MimeResponds
#   # include ActionController::ImplicitRender
#   # include ActionController::StrongParameters
#   # # include ActionController::Cookies
#   # include ActionController::RequestForgeryProtection
#   # # include ActionController::RecordIdentifier

#   # # These are included in ActionController::API
#   # # include ActionController::UrlFor
#   # # include ActionController::Redirecting
#   # # include ActionController::ConditionalGet
#   # # include ActionController::RackDelegation

#   # # include AbstractController::Callbacks

# end

module RestApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Adding neccesary middleware for devise
    config.middleware.use config.session_store, config.session_options

    # These may actually be optional (devise), try removing them at some point
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.middleware.use ActionDispatch::Flash

    # Prevent devise helpers from being cleared
    # config.action_controller.include_all_helpers = false

    # remove when api login page has been removed
    # config.action_view.javascript_expansions[:defaults] = %w(jquery.min jquery_ujs)

    # Required for Devise on Heroku
    config.assets.initialize_on_precompile = false

    # Load lib paths for custom warden failure
    # config.autoload_paths += %W(#{config.root}/lib)
  end
end
