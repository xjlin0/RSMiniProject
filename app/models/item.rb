class Item < ActiveRecord::Base

  include ItemsHelper

  has_many :items_users
  has_many :users, through: :items_users

  has_many :categories_items
  has_many :categories, through: :categories_items

  def self.import(filename, csv_options)
    CSV.foreach(filename, csv_options) do |row|
      p Item.create!(id: row[:item_id], name: row[:name]) rescue (print "Record not saved: "; p row)
    end
  end

  def self.recommendations_string(items_relations, seperator=", ")
    results = Array.new
    items_relations.each do |item|
      results << "#{item.name} (#{item.category_names_string})"
    end
    results.join(seperator)
  end

end
