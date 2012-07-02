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
      redirect_to join_room_path(:room_id => @room.id)
    else
      redirect_to rooms_path, alert: "Error creating room"
    end
  end

  def join
    @room = Room.find(params[:room_id])
  end

  def choose
    respond_to do |format|
      format.js do

      end
    end
  end
  # Generate new questions for the input room when it run out of buffer questions
  def generate_questions(room)
    # Temporarily assign all the questions to each room
    room.questions = Question.all
    room.save
  end

  # Choose new question from buffer questions
  def choose_question(room)
    # Temporarily choose a random question from buffer
    this_questions = room.questions
    next_question = this_questions[rand(0..this_questions.length)]
    # Delete the next_question from the buffer
    QuestionsBuffer
      .where(room_id: room.id, question_id:next_question.id)
      .destroy
    
    room.question = next_question
    room.save
  end
end
