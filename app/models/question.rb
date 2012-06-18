class Question < ActiveRecord::Base
  validates :title,:prompt, :question_type_id, presence: true
  validate :contains_correct_choice

  belongs_to :paragraph
  belongs_to :question_type
  has_many :choices,dependent: :destroy
  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c[:content].blank?}, :allow_destroy => true

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
