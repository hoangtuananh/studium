Pusher.app_id = '22619'
Pusher.key = '9a81f498ef1031e46675'
Pusher.secret = 'c90fd082578b9efe4f69'
class RoomsController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery

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
      # See application_controller for publish method.
      publish("rooms", "create", {room_id: @room.id})
      redirect_to room_join_path(@room.id)
    else
      redirect_to rooms_path, alert: "Error creating room"
    end
  end

  def join
    
    @room = Room.find(params[:room_id])
    current_user.room_id = @room.id
    current_user.status = 1
    current_user.save
    choose_question(@room) unless @room.question
    publish("presence-room_#{@room.id}","users_change", {})
  end

  # Request type: POST
  # Input params: none
  # Return: HTML of the user list of the room the user is in
  # Used for dynamically updating user list in each room
  def user_list
    @room = current_user.room
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
    @room = current_user.room
    @current_question = @room.question
    new_history_item = History.new({user_id: current_user.id, room_id: @room.id, question_id: @room.question.id, choice_id: @choice_id})
    new_history_item.save
    current_user.status = 2
    current_user.save
    publish("presence-room_#{@room.id}", "users_change", {})
    publish("presence-room_#{@room.id}", "update_histories", {
      history_id: new_history_item.id
    })
    publish("presence-room_#{@room.id}", "show_explanation", {
      question_id: @current_question.id
    }) if @room.show_explanation?
    render :json => {
      current_question_id: @current_question.id,
      choice_id: @choice_id
    }
  end
  
  # Request type: POST
  # Input: room_id
  # Effect: change user's status to 3 (Ready). 
  #   If everyone is ready then choose next question and publish to /rooms/next_question
  def ready
    @room = current_user.room
    current_user.status = 3
    current_user.save
    publish("presence-room_#{@room.id}","users_change",{})
    if @room.show_next_question?
      @next_question = choose_question(@room)
      publish("presence-room_#{@room.id}","next_question", {
        question_id: @next_question.id
      })
    end
    render :json => {
      room_id: @room.id
    }
  end

  # Request type: GET
  # User quiting the room
  # Note: this is different from kick since it's user clicking the quit button, not closing the window. It's called by the user himself
  def quit
    current_user.room_id = 0
    current_user.status = 0
    redirect_to rooms_path
  end

  # Request type: POST
  # Other users kicking some user (because he closed his window)
  # Effect: Kick the user from the room (set room_id and status to 0)
  #         Publish users_change event
  def kick
    user = User.find(params[:user_id])
    old_room_id = user.room_id
    user.room_id = 0
    user.status = 0
    user.save
    publish("presence-room_#{old_room_id}", "users_change", {})
    render :text => "Kicked", :status => '202'
  end
  # Input: question_id
  # Return: HTML of that question
  def show_question
    @question = Question.find(params[:question_id])
    render :partial => "show_question"
  end

  # Request type: POST
  # Input: choice_id
  # Return: HTML of the explanation for the question in the room the user is in
  def show_explanation
    @room = current_user.room
    return if !@room.show_explanation?
    @question = @room.question
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
    generate_questions(room) if room.questions.empty?
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

  def show_histories
    @room=Room.find params[:room_id]
    render @room.histories
  end
end
