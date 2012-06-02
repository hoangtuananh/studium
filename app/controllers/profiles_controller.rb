class ProfilesController < ApplicationController
  before_filter :find_user
  before_filter :find_profile
  before_filter :authenticate_update!,only: [:edit,:update]

  def show
  end

  def edit
  end

  def update
    @profile.update_attributes! params[:profile]
    redirect_to user_profile_url(@user),notice: "Profile has been updated."

  rescue
    flash[:alert]="Profile has not been updated."
    render "edit"
  end

private
  def find_user
    @user=User.find params[:user_id]

  rescue
    redirect_to index_url,alert: "The user you were looking for could not be found."
  end

  def find_profile
    @profile=@user.profile
  end

  def authenticate_update!
    redirect_to index_url,alert: "You do not have permission to update the profile of that user." unless user_signed_in? and current_user==@user
  end
end
