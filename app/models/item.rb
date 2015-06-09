class Item < ActiveRecord::Base

  include ItemsHelper

  has_many :items_users
  has_many :users, through: :items_users

  has_many :categories_items
  has_many :categories, through: :categories_items

  def self.import(arguments = {})
    filename    = arguments.fetch(:filename)
    csv_options = arguments.fetch(:csv_options)

    CSV.foreach(filename, csv_options) do |row|
      p Item.create!(id: row[:item_id], name: row[:name]) rescue (print "Record not saved: "; p row)
    end
  end

  def self.with_exact_categories(arguments = {})
    category_ids = arguments.fetch(:category_ids)
    limit        = arguments.fetch(:limit) {50}

    if category_ids.length == 1
      return self.
      joins(:categories).
      where('categories.id': category_ids).
      group(:id).
      having('items.categories_count = ?', category_ids.length).
      limit(limit)
    else
      return self.
      joins(:categories).
      where('categories.id': category_ids).
      group(:id).
      having('count(categories.id) = ?', category_ids.length).
      limit(limit)
    end
  end #http://stackoverflow.com/questions/28733170

  def self.with_more_categories(arguments = {})
    category_ids = arguments.fetch(:category_ids)
    limit        = arguments.fetch(:limit) {50}

    self.
    joins(:categories).
    where('categories.id': category_ids).
    group('items.id').
    having('count(categories.id) > ?', category_ids.length).
    order('count_categories_id asc').
    count('categories.id')
    limit(limit)
  end #http://stackoverflow.com/questions/28733170

  def self.with_any_categories(arguments = {})
    category_ids = arguments.fetch(:category_ids)
    limit        = arguments.fetch(:limit) {50}

    self.
    joins(:categories).
    where('categories.id': category_ids).
    group(:id).
    limit(limit)
  end #http://stackoverflow.com/questions/28733170

  def self.recommendations_string(arguments = {})
    items_array  = arguments.fetch(:items_array)
    seperator    = arguments.fetch(:seperator) {", "}

    recommendations = Array.new
    items_array.each do |item|
      recommendations << "#{item.id}: #{item.name} (#{item.category_names_string})"
    end
    recommendations.join(seperator)
  end

end
