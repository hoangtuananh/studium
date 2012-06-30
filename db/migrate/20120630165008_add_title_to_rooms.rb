class AddTitleToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :title, :string
  end
end
