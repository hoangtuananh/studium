class RoomsController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  # Request type: POST
  # Return: the room list
  # Used for dynamically updating the room list
  def room_list
    @rooms = Room.all
    render partial: "room_list"
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
    generate_questions(@room) unless !@room.questions.empty?
    choose_question(@room) unless @room.question
    faye_publish("/rooms/users_change/#{@room.id}", current_user.profile.attributes)
  end

  # Request type: POST
  # Input params: room_id
  # Return: HTML of the user list of that specific room
  # Used for dynamically updating user list in each room
  def user_list
    @room = Room.find(params[:room_id])
    @user_list = @room.users
    @status = ["Not in any room", "Answering", "Confirmed", "Ready"]
    render partial: "user_list"
  end
  # Request type: POST
  # Input params: choice_id, room_id
  # Effect: create new history item, choose next question
  # Return: current question's id, next question's id, selected choice's id 
  def choose
    @choice_id = params[:choice_id]
    @room = Room.find(params[:room_id])
    @current_question = @room.question
    new_history_item = History.new({user_id: current_user.id, room_id: @room.id, question_id: @room.question.id, choice_id: @choice_id})
    new_history_item.save
    current_user.status = 2
    current_user.save
    faye_publish("/rooms/users_change/#{@room.id}",{})
    faye_publish("/rooms/show_explanation/#{@room.id}",{
      choice_id: @choice_id,
      question_id: @current_question.id
    }) if @room.show_explanation?
    render :json => {
      current_question_id: @current_question.id,
      choice_id: @choice_id
    }
  end
  
  def ready
    @room = Room.find(params[:room_id])
    current_user.status = 3
    current_user.save
    faye_publish("/rooms/users_change/#{@room.id}", {})
    if @room.show_next_question?
      @next_question = choose_question(@room)
      faye_publish("/rooms/next_question/#{@room.id}", {
        question_id: @next_question.id
      })
    end
    render :json => {
      room_id: @room.id
    }
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

  # Request type: POST
  # Input: room_id
  # Return HTML of the individual room item to be shown on rooms#index (Used for real-time room list)
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
