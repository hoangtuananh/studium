class DropCorrectChoiceIdFromQuestion < ActiveRecord::Migration
  def up
    remove_column :questions, :correct_choice_id
  end

  def down
    add_column :questions, :correct_choice_id, :integer
  end
end
