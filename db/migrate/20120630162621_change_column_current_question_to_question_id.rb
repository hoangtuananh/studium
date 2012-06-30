class ChangeColumnCurrentQuestionToQuestionId < ActiveRecord::Migration
  def up
    remove_column :rooms, :current_question
    add_column :rooms, :question_id, :integer
  end

  def down
    add_column :rooms, :current_question, :integer
    remove_column :rooms, :question_id
  end
end
