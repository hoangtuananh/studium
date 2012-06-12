class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :prompt
      t.integer :correct_choice_id
      t.integer :exp
      t.integer :category_id

      t.timestamps
    end
  end
end
