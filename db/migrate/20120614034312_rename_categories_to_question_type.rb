class RenameCategoriesToQuestionType < ActiveRecord::Migration
  def up
    rename_table :categories,:question_types
  end

  def down
    rename_table :question_types,:categories
  end
end
