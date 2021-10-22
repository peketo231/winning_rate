require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WinningRate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators do |g|
      g.skip_routes true
      g.assets false
      g.helper false
      g.test_framework false
    end

    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}').to_s]

    config.time_zone = 'Tokyo'

    config.action_view.field_error_proc = proc do |html_tag, instance|
      if instance.is_a?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        object_name = instance.instance_variable_get(:@object_name)
        method_name = instance.instance_variable_get(:@method_name)
        error_icon = html_tag.gsub('form-control', 'form-control is-invalid').html_safe
        error_message = "<div class=\"invalid-feedback\">#{I18n.t("activerecord.attributes.#{object_name}.#{method_name}")}#{instance.error_message.first}</div>".html_safe
        error_icon.concat(error_message)
      end
    end
  end
end
