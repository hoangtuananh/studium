class HomepageController < ApplicationController
  def index
    # If user has already signed in, redirect to dashboard
    if user_signed_in?
      redirect_to user_root_url,alert: flash[:alert]
    end
  end
end
