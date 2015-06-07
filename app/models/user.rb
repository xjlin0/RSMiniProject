class User < ActiveRecord::Base
  has_many :items_users
  has_many :items, through: :items_users

  def self.import(filename, csv_options)
    CSV.foreach(filename, csv_options) do |row|
      p User.create(id: row[:user_id], name: row[:name])
    end
  end

  def recommended_items
    self.name + " got Recommended items!"
  end
end