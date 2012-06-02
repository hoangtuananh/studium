class ProfilesController < ApplicationController
  before_filter :find_user

  def show
    @profile=@user.profile 
  end

private
  def find_user
    @user=User.find params[:user_id]

  rescue
    redirect_to index_url,alert: "The user you were looking for could not be found."
  end
end
