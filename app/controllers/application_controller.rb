class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def authenticate_admin!
    redirect_to index_url,alert: "The page you were looking for could not be found." unless user_signed_in? and current_user.admin?
  end

  def authenticate_user!
    redirect_to index_url,alert: "You have to sign in" unless user_signed_in?
  end
end
