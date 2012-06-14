class RemoveNameFromQuestionTypes < ActiveRecord::Migration
  def up
    remove_column :question_types, :name
  end

  def down
    add_column :question_types, :name, :string
  end
end
