ActiveAdmin.register User do

  permit_params :id, :name, items: []
  config.filters = false
  config.sort_order = 'id_asc'

  index do
    column :id
    column("Name", sortable: :name) {|user| link_to "#{user.name} ", admin_user_path(user) }
    column ("Items (categories)") do |user|
      table_for user.items do
        column { |item| "#{item.name} (#{item.category_names_string})" }
      end
    end
  end

  show do
    panel "Details" do
      table_for(user.items) do |t|
        t.column("Purchase Items (Categories)") {|item| "#{item.name} (#{item.category_names_string})"  }
        t.column("Recommendations (Categories)") {|item| "#{Item.recommendations_string(item.similar_items(user))}" }
      end
    end
  end

end
