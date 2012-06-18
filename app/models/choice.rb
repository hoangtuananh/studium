class Choice < ActiveRecord::Base
  belongs_to :question, :dependent => :destroy

  validates :content,presence: true
end
