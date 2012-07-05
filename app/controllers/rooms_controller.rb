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
    if @room.save
      # See application_controller for faye_publish method.
      # @room.attributes returns a hash of the room's attributes
      faye_publish("/rooms/create", {room_id: @room.id})
      redirect_to room_join_path(:room_id => @room.id)
    else
      redirect_to rooms_path, alert: "Error creating room"
    end
  end

  def join
    @room = Room.find(params[:room_id])
    current_user.room_id = @room.id
    current_user.status = 1
    current_user.save
    @user_list = @room.users
    generate_questions(@room) unless !@room.questions.empty?
    choose_question(@room) unless @room.question
    faye_publish("/rooms/join/#{@room.id}", current_user.profile.attributes)
  end

  # Input params: choice_id, room_id
  # Effect: create new history item, choose next question
  # Return: JSON format of next question
  def choose
    @choice_id = params[:choice_id]
    @room = Room.find(params[:room_id])
    @current_question = @room.question
    new_history_item = History.new({user_id: current_user.id, room_id: @room.id, question_id: @room.question.id, choice_id: @choice_id})
    new_history_item.save
    @next_question = choose_question(@room)
    respond_to do |format|
      format.json do
        render :json => {
          current_question_id: @current_question.id,
          next_question_id: @next_question.id,
          choice_id: @choice_id
        }
      end
    end
  end
  
  # Input: question_id
  # Return: HTML of that question
  def show_question
    @question = Question.find(params[:question_id])
    render :partial => "show_question"
  end

  # Request type: POST
  # Input: question_id, choice_id
  # Return: HTML of the explanation for that question
  def show_explanation
    @question = Question.find(params[:question_id])
    @selected_choice = Choice.find(params[:choice_id])
    if @selected_choice.correct?
      @message = "Congratulations! You got the right answer."
      @class = "alert alert-success"
    else
      @message = "Sorry, you got the wrong answer. See explanation below."
      @class = "alert alert-error"
    end
    render :partial => "show_explanation"
  end

  def show_new_room_item
    room = Room.find(params[:room_id])
    render :partial => "room_item", :locals => {room: room}
  end
  # Generate new questions for the input room when it run out of buffer questions
  def generate_questions(room)
    # Temporarily assign all the questions to each room
    room.questions = Question.all
    room.save
  end

  # Choose new question from buffer questions
  def choose_question(room)
    generate_questions(room) if (room.questions.empty?)
    # Temporarily choose a random question from buffer
    this_questions = room.questions
    r = Random.new
    next_question = this_questions[r.rand(0..this_questions.length-1)]
    # Delete the next_question from the buffer
    QuestionsBuffer
      .where({room_id: room.id, question_id:next_question.id})
      .destroy_all
    
    room.question = next_question
    room.save
    return next_question
  end
end
