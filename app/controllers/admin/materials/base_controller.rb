class Admin::Materials::BaseController < ApplicationController
  before_filter :authenticate_admin!

  def index
  end
end
