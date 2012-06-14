class RenameQuestionIdInQuestionTypesToCategoryId < ActiveRecord::Migration
  def up
    rename_column :question_types,:question_id,:category_type_id
  end

  def down
    rename_column :question_types,:category_type_id,:question_id
  end
end
