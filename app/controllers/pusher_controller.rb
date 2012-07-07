class PusherController < ApplicationController
  protect_from_forgery :except => :auth
  def auth
    if current_user
      data = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        user_id: current_user.id,
        user_info: {
          name: current_user.name,
          email: current_user.email
        }
      })
      render :json => data
    else
      render :text => "Forbidden", :status => '403'
    end
  end
end
