class CategoriesItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :item, counter_cache: :categories_count

  def self.import(arguments = {})
    filename    = arguments.fetch(:filename)
    csv_options = arguments.fetch(:csv_options)
    CSV.foreach(filename, csv_options) do |row|
      p CategoriesItem.create!(item_id: row[:item_id], category_id: row[:category_id]) rescue (print "Record not exist: "; p row)
    end
  end

end
