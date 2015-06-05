class CreateItemsUsers < ActiveRecord::Migration
  def change
    create_table :items_users do |t|
      t.references :item, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
