# frozen_string_literal: true

require File.expand_path('boot', __dir__)

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Mesa
  class Application < Rails::Application
    config.browserify_rails.commandline_options = '-t [ babelify --presets [ es2015 ] ]'

    config.action_view.field_error_proc = proc { |tag|
      "<span class='is-with-error'>#{tag}</span>".html_safe
    }

    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |generate|
      generate.stylesheets false
      generate.javascripts false
      generate.helpers false
    end

    config.middleware.insert_before 0, 'Rack::Cors' do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[options get]
      end
    end
  end
end
