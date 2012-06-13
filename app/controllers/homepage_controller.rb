class HomepageController < ApplicationController
  before_filter :authenticate_user!,only: [:admin]
  before_filter :authenticate_admin!,only: [:admin]

  def index
    # If user has already signed in, redirect to dashboard
    if user_signed_in?
      redirect_to user_root_url,alert: flash[:alert]
    end
  end

  def admin
  end

  def materials
  end
end
