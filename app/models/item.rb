class Item < ActiveRecord::Base
  has_many :items_users
  has_many :users, through: :items_users

  has_many :categories_items
  has_many :categories, through: :categories_items

  def self.import(filename, csv_options)
    CSV.foreach(filename, csv_options) do |row|
      p Item.create!(id: row[:item_id], name: row[:name]) rescue (print "Record not saved: "; p row)
    end
  end

  def category_names_string(seperator=", ")
    self.categories.pluck(:name).join(seperator)
  end

  def similar_items(limit=3, seperator=" | ")
    item_categories_array = self.categories.pluck(:id) #get all category ids to query database
    #The following sql querys by item's category id, sorted by number of returned items category.
    id_hash = Item.joins(:categories).where('categories_items.category_id': item_categories_array).group('items.id').order('count_categories_items_category_id desc').limit(limit+1).count('categories_items.category_id')
    id_hash.delete(self.id)  #remove caller itself from the query results, if present
    id_hash.keys.first(limit).map{|relatives_id| Item.find(relatives_id)}
  end

  def self.recommendations_string(items_array, seperator=", ")
    results = Array.new
    items_array.each do |item|
      results << "#{item.name} (#{item.category_names_string})"
    end
    results.join(seperator)
  end
end