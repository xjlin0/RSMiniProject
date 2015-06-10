# RSMiniProject
Practice of Ruby on Rails Portal with Recommendations Algorithm

Demo link:
http://mini-proj.herokuapp.com

## Structure:

By using the ActiveAdmin gem (bundle with Devise), Here is the demo project for displaying 3 tables for models and 2 as the join tables.  After data seeding, the major three files doing the work are:

1. View: /app/admin/user.rb    DSL for ActiveAdmin tables.
2. Model: /app/models/item.rb  All class methods including recommendation method.
3. Helper: /app/helpers/items_helper.rb  Helper methods for ActiveRecord query supporting recommendations.