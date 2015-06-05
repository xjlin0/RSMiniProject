class Item < ActiveRecord::Base
  has_many :items_users
  has_many :users, through: :items_users

  has_many :categories_items
  has_many :categories, through: :categories_items

  def self.import(filename, csv_options)
    CSV.foreach(filename, csv_options) do |row|
      p Item.find_or_create_by!(id: row[:item_id], name: row[:name])
    end
  end

end