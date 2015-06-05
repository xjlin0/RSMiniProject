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
User.import("mini_proj-users.csv", csv_options)
ItemsUser.import("mini_proj-items_users.csv", csv_options)