class User < ActiveRecord::Base
  has_many :items_users
  has_many :items, through: :items_users

  def self.import(arguments = {})
    filename    = arguments.fetch(:filename)
    csv_options = arguments.fetch(:csv_options)

    CSV.foreach(filename, csv_options) do |row|
      p User.create(id: row[:user_id], name: row[:name]) rescue (print "Record not saved: "; p row)
    end
  end

end
