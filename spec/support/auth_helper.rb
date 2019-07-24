# frozen_string_literal: true
module AuthHelper
  def auth
    credentials = ActionController::HttpAuthentication::Basic.encode_credentials ENV['USERNAME'], ENV['PASSWORD']
    request.env['HTTP_AUTHORIZATION'] = credentials
  end
end
