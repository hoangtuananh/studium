class Room < ActiveRecord::Base
  attr_accessible :current_question, :last_activity
  belongs_to :room, {foreign_key: "current_question"}
end
