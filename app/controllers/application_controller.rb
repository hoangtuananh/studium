class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def authenticate_admin!
    redirect_to index_url,alert: "The page you were looking for could not be found." unless user_signed_in? and current_user.admin?
  end

  def authenticate_user!
    redirect_to index_url,alert: "You have to sign in" unless user_signed_in?
  end
  # Sends a POST request to http://localhost:9292/faye with an object containing the channel and the data.
  # This is equivalent to client.publish(channel,data) in views
  def faye_publish(channel, data)
    msg = JSON.dump({
      channel: channel,
      data: data
    })
    Net::HTTP.post_form(URI.parse('http://localhost:9292/faye'), message: msg)
  end
end
