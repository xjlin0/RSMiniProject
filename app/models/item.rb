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
    minus        = arguments.fetch(:minus) {[]}

    self.
      joins(:categories).
      where.not(id: minus).
      where('categories.id': category_ids).
      where('items.categories_count = ?', category_ids.length).
      group('items.id').
      having('count(categories.id) = ?', category_ids.length).
      limit(limit)
  end #http://stackoverflow.com/questions/28733170

  def self.matched_any_categories(arguments = {})
    category_ids = arguments.fetch(:category_ids)
    limit        = arguments.fetch(:limit) {50}
    minus        = arguments.fetch(:minus) {[]}

    self.
      joins(:categories).
      where.not(id: minus).
      where('categories.id': category_ids).
      group('items.id').
      order('count_categories_id desc').
      count('categories.id')
    limit(limit)
  end #http://stackoverflow.com/questions/28733170

  def self.suggest_promotions(arguments = {})
    promotion_items_ids = arguments.fetch(:promotion_items_ids)
    limit               = arguments.fetch(:limit) {50}
    minus               = arguments.fetch(:minus) {[]}

    self.
      where.not(id: minus).
      find(promotion_items_ids).
      limit(limit)
  end

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
