class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :date_of_birth
      t.string :school
      t.integer :user_id

      t.timestamps
    end
  end
end
