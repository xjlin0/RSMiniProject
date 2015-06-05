class Category < ActiveRecord::Base
  has_many :categories_items
  has_many :items, through: :categories_items

  def self.import(filename, csv_options)
    CSV.foreach(filename, csv_options) do |row|
      p Category.find_or_create_by!(id: row[:category_id], name: row[:name])
    end
  end
end