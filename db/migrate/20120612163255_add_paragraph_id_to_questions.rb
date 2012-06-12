class AddParagraphIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :paragraph_id, :integer
  end
end
