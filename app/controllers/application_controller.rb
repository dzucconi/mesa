class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  protect_from_forgery with: :exception
end
