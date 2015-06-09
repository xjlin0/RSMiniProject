class ItemsUser < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  def self.import(arguments = {})
    filename    = arguments.fetch(:filename)
    csv_options = arguments.fetch(:csv_options)

    CSV.foreach(filename, csv_options) do |row|
      p ItemsUser.create!(item_id: row[:item_id], user_id: row[:user_id]) rescue (print "Record not exist: "; p row)
    end
  end

end
