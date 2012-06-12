class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.text :content
      t.string :title
      t.integer :question_id

      t.timestamps
    end
  end
end
