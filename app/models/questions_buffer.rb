class QuestionsBuffer < ActiveRecord::Base
  attr_accessible :question_id, :room_id
  belongs_to :question
  belongs_to :room
end
