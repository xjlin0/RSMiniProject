class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :items_users
  has_many :items, through: :items_users

  #http://stackoverflow.com/questions/9165843/devise-not-requiring-email#18017413
  def email_required?
    false
  end

  def email_changed?
    false
  end

  # def self.import(filename, csv_options)   #This is too slow
  #   CSV.foreach(filename, csv_options) do |row|
  #     p User.create(id: row[:user_id], name: row[:name], password: "password")
  #   end
  # end

  def self.importer_worker(csvdata_in_array_of_hashes) #ordinary CSV is slow
    ActiveRecord::Base.connection.reconnect!
    csvdata_in_array_of_hashes.each do |row|
      p User.create(id: row[:user_id], name: row[:name], password: "password")
    end
  end


end
