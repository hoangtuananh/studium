class History < ActiveRecord::Base
  attr_accessible :choice_id, :created, :question_id, :user_id,:room_id
  belongs_to :user
  belongs_to :question
  belongs_to :choice
  belongs_to :room
end
