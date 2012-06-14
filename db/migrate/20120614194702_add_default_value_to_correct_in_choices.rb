class AddDefaultValueToCorrectInChoices < ActiveRecord::Migration
  def up
    change_column :choices,:correct,:boolean,default: false
  end

  def down
    change_column :choices,:correct,:boolean,default: nil
  end
end
