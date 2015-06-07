ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  config.filters = false
  config.sort_order = 'id_asc'
  permit_params :id, :name, items: []

    index do
      column :id
      column("Name", :sortable => :name) {|user| link_to "##{user.name} ", admin_user_path(user) }


      column ("Items (categories)") do |user|
        table_for user.items do
          column do |item|
            all_category_name = item.categories.inject(""){|a,e|a+e.name+", "}.chomp(", ")
            "#{item.name} (#{all_category_name})"
          end
        end
      end



    end
end
