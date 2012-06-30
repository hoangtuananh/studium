class Room < ActiveRecord::Base
  attr_accessible :current_question, :last_activity
  belongs_to :question
  has_many :questions_buffers
  has_many :questions, :through => :questions_buffers
end
