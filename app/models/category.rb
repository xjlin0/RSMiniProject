class Category < ActiveRecord::Base
  has_many :categories_items, dependent: :destroy
  has_many :items, through: :categories_items, dependent: :destroy

  def self.import(arguments = {})
    filename    = arguments.fetch(:filename)
    csv_options = arguments.fetch(:csv_options)
    CSV.foreach(filename, csv_options) do |row|
      p Category.create!(id: row[:category_id], name: row[:name]) rescue (print "Record not saved: "; p row)
    end
  end

end
