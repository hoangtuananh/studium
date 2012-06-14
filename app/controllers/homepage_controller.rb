class HomepageController < ApplicationController
  before_filter :authenticate_admin!,only: [:admin,:materials]

  def index
    # If user has already signed in, redirect to dashboard
    if user_signed_in?
      redirect_to user_root_url,alert: flash[:alert]
    end
  end

  def admin
  end
end
