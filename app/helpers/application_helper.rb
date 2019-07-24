# frozen_string_literal: true
module ApplicationHelper
  def view
    [controller.controller_path, controller.action_name].join '_'
  end

  def logged_in?
    session[:authenticated] || false
  end
end
