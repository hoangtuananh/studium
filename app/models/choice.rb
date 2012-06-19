class Choice < ActiveRecord::Base
  belongs_to :question

  validates :content,presence: true
end
