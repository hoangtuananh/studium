class Question < ActiveRecord::Base
  validates_presence_of :prompt, :correct_choice_id, :question_type_id
  belongs_to :question_type
  has_many :choices
  belongs_to :correct_choice
  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c[:content].blank?}
end
