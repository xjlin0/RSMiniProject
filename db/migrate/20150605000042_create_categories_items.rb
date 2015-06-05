class CreateCategoriesItems < ActiveRecord::Migration
  def change
    create_table :categories_items do |t|
      t.references :category, index: true#, foreign_key: true
      t.references :item, index: true#, foreign_key: true

      t.timestamps null: false
    end
  end
end
