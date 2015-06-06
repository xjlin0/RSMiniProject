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
      column :name


      column :items do |user|
        table_for user.items do
          column do |item|
            "#{item.name} (#{item.categories.first.name})"
          end
        end
      end

      # column :items do |user|
      #   p user.items
      # end



    end
end
