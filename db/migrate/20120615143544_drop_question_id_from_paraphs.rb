class DropQuestionIdFromParaphs < ActiveRecord::Migration
  def up
    remove_column :paragraphs, :question_id
  end

  def down
    add_column :paragraphs, :question_id, :integer
  end
end
