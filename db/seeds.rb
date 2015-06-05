# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   csv_options = {headers: :true, col_sep: "\t" ,header_converters: :symbol}
require 'csv'
csv_options = {
                headers: :true,
                col_sep: "\t",
                header_converters: :symbol,
              }

Item.import("mini_proj-items.csv", csv_options)
Category.import("mini_proj-categories.csv", csv_options)
CategoriesItem.import("mini_proj-categories_items.csv", csv_options)
#User.import("mini_proj-users.csv", csv_options)  #password is "password"

parallel_options = {chunk_size: 1000, col_sep: "\t", row_sep: "\n", verbose: true, remove_empty_values: false, remove_zero_values: false, convert_values_to_numeric: false}
csv = SmarterCSV.process("mini_proj-users.csv", parallel_options)
Parallel.map(csv) do |chunk|
  User.importer_worker(chunk)
end
sleep 65
ActiveRecord::Base.connection.reconnect!
ItemsUser.import("mini_proj-items_users.csv", csv_options)
