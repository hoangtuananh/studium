class AddRoomIdToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :room_id, :integer
  end
end
