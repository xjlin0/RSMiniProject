ActiveAdmin.register User do

  permit_params :id, :name, items: []
  config.filters = false
  config.sort_order = 'id_asc'

  controller do
    def scoped_collection
      super.includes(:items, {items: :categories})
    end
  end

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
        t.column("ID: Purchase Items (Categories)") {|item| "#{item.id}: #{item.name} (#{item.category_names_string})"  }
        t.column("ID: Recommendations (Categories)") {|item| "#{Item.recommendations_string(items_relations: item.similar_items(user: user))}" }
      end
    end
  end

end
