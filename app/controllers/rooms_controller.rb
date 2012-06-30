class RoomsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @rooms = Room.all
  end
  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])
  end

  def join
    @room = Room.find(params[:room_id])
  end

  def generate_questions(room)
    
end
