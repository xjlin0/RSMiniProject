ActiveAdmin.register Item do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  config.filters = false
  permit_params :id, :name, users: [], categories: []
  # or
  ## From http://www.eileencodes.com/posts/has-many-relationships-in-activeadmin
  # index do
  #   column("ID", :sortable => :id) {|item| link_to "##{item.id} ", admin_item_path(item) }
  #   column("Name", :sortable => :name) {|item| link_to "##{item.name} ", admin_item_path(item) }
  #   column :categories do |item|
  #     table_for item.categories.order('name ASC') do
  #       column{|category| link_to "##{category.name} ", admin_category_path(category) }
  #     end
  #   end
  # end
  #
  # From http://www.eileencodes.com/posts/has-many-relationships-in-activeadmin
  # index do
  #   column :id
  #   column :name
  #   column :categories do |item|
  #     table_for item.categories.order('name ASC') do
  #       column{ |category| category.name }
  #     end
  #   end
  # end

    index do
      column :id
      column :name
      column ("First Category") do |item|
        p item.categories.first.name

      # table_for item.categories.order('name ASC') do
      #   column{ |category| category.name }
      # end
      end
    end

end