class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :action
      t.integer :user_id
      t.integer :thing_id
      t.string :thing_type

      t.timestamps
    end
  end
end
