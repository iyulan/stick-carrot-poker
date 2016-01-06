module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: 'alert-success', danger: 'alert-danger', warning: 'alert-warning', info: 'alert-info' }[flash_type]
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type.to_sym)} alert-dismissible") do
          concat content_tag(:button, '&times;'.html_safe, class: 'close', data: { dismiss: 'alert' })
          concat content_tag(:strong, message)
        end
      )
    end
    nil
  end
end
