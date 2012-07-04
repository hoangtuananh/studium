class Room < ActiveRecord::Base
  belongs_to :question
  has_many :questions_buffers
  has_many :questions, :through => :questions_buffers
  has_many :users
end
