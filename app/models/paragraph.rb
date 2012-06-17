class Paragraph < ActiveRecord::Base
  has_many :questions
  accepts_nested_attributes_for :questions, :reject_if => lambda { |q| q[:title].blank?}, :allow_destroy => true
  validates :title, :content, presence: true
  validate :contains_questions

  def contains_questions
    if self.questions.empty?
      errors.add(:question, "Paragraph must have at least one question")
    end
  end
end
