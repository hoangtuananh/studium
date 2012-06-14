class Question < ActiveRecord::Base
  belongs_to :question_type
  has_many :choices
  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c.content.blank?}
end
