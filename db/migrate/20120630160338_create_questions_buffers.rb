class CreateQuestionsBuffers < ActiveRecord::Migration
  def change
    create_table :questions_buffers do |t|
      t.integer :question_id
      t.integer :room_id

      t.timestamps
    end
  end
end
