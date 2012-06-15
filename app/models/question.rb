class Question < ActiveRecord::Base
  validates :prompt, :question_type_id, presence: true
  belongs_to :paragraph
  belongs_to :question_type
  has_many :choices
  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c[:content].blank?}, :allow_destroy => true
  validate :contains_correct_choice
  def contains_correct_choice
    choices = self.choices
    if choices.empty?
      errors.add(:choice, "Question must have at least one choice")
    end
    has_correct= false
    choices.each do |choice|
      has_correct = true if choice.correct
    end
    if !has_correct
      errors.add(:choice, "Question must have at least one correct choice")
    end
  end
end
