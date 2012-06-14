class QuestionType < ActiveRecord::Base
  belongs_to :category_type
  has_many :questions
  def is_sentence_completion?
    self.type_name=="Sentence Completion"
  end
  def is_sentence_improvement?
    self.type_name=="Sentence Improvement"
  end
end
