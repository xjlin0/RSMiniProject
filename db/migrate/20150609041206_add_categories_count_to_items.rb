class AddCategoriesCountToItems < ActiveRecord::Migration
  def change
    add_column :items, :categories_count, :integer, default: 0
  end
end
