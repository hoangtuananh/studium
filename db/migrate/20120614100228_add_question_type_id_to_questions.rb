class AddQuestionTypeIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :question_type_id, :integer
  end
end
