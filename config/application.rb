require File.expand_path('../boot', __FILE__)

require 'rails/all'

# 自定义扩展
require File.expand_path('../../lib/plugins/expands', __FILE__)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Miclle
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'

    # [deprecated] I18n.enforce_available_locales will default to true in the future. If you really want to skip validation of your locale you can set I18n.enforce_available_locales = false to avoid this message.
    config.i18n.enforce_available_locales = false
    # or if one of your gem compete for pre-loading, use
    I18n.config.enforce_available_locales = false

    config.to_prepare do
      DeviseController.respond_to :html, :json
      Devise::Mailer.layout "mailer"
    end

    config.exceptions_app = self.routes

  end
end
