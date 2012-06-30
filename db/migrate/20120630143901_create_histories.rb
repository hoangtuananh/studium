class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :choice_id
      t.timestamp :created

      t.timestamps
    end
  end
end
