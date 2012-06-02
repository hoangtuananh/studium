module DeviseHelper
  def devise_error_messages2!
    #resource.errors.full_messages.map {|msg|  content_tag(:p, msg, :class => "alert alert-error")}.join
    if !resource.errors.full_messages.empty?
      flash[:alert] = resource.errors.full_messages.join(". ")
    end
  end
end
