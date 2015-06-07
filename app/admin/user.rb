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
    column("Name", sortable: :name) {|user| link_to "##{user.name} ", admin_user_path(user) }
    column ("Items (categories)") do |user|
      table_for user.items do
        column { |item| "#{item.name} (#{item.category_names})" }
      end
    end
  end

  show do
    panel "Details" do
      table_for(user.items) do |t|
        t.column("Item") {|item| item.name  }
        t.column("Category") {|item| item.category_names }
      end
    end
    panel "Recommended items" do
      user.recommended_items
    end
  end

  # show do
  #   panel "Invoice" do
  #     table_for(order.line_items) do |t|
  #       t.column("Product") {|item| auto_link item.product        }
  #       t.column("Price")   {|item| number_to_currency item.price }
  #       tr :class => "odd" do
  #         td "Total:", :style => "text-align: right;"
  #         td number_to_currency(order.total_price)
  #       end
  #     end
  #   end
  # end


end
