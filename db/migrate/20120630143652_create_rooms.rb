class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :current_question
      t.timestamp :last_activity

      t.timestamps
    end
  end
end
