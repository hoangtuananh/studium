class Choice < ActiveRecord::Base
  belongs_to :question, :dependent => :destroy
  has_one :question, :foreign_key => :correct_choice_id
end
