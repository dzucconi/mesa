class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD'], only: %i(new edit create update destroy)

  protect_from_forgery with: :exception
end
