class RenameTypeColumnInQuestionTypesAndCategoryTypes < ActiveRecord::Migration
  def up
    rename_column :category_types,:type,:category_name
    rename_column :question_types,:type,:type_name
  end

  def down
  end
end
