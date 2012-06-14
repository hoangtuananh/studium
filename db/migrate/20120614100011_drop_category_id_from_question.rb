class DropCategoryIdFromQuestion < ActiveRecord::Migration
  def up
    remove_column :questions, :category_id
  end

  def down
    add_column :questions, :cateogry_id, :string
  end
end
