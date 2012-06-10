class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def authenticate_admin!
    redirect_to index_url,alert: "You have to be signed in as an administrator to perform that action." unless user_signed_in? and current_user.admin?
  end
end
