# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
csv_options = {
                headers: :true,
                col_sep: "\t",
                converters: :numeric,
                header_converters: :symbol,
              }

Item.import("mini_proj-items.csv", csv_options)