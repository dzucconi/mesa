module ApplicationHelper
  def view
    [controller.controller_path, controller.action_name].join '_'
  end
end
