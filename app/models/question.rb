class Question < ActiveRecord::Base
  validates :prompt, :correct_choice_id, :question_type_id, presence: true
  belongs_to :question_type
  has_many :choices
  belongs_to :choice, foreign_key: "correct_choice_id"
  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c[:content].blank?}
end
