# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  attr_reader :current_user

  protect_from_forgery with: :exception

  private

  def authenticate!
    authenticate_or_request_with_http_basic do |username, password|
      @current_user = User.new(
        authenticated: username == ENV['USERNAME'] && password == ENV['PASSWORD']
      )

      session[:authenticated] = @current_user.authenticated?
    end
  end
end
