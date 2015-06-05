class CategoriesItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :item

  def self.import(filename, csv_options)
    CSV.foreach(filename, csv_options) do |row|
      p CategoriesItem.create!(item_id: row[:item_id], category_id: row[:category_id]) rescue (print "Record not exist: "; p row)
    end
  end

end
