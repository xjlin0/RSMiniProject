module ItemsHelper

  def category_names_string(arguments = {})
    seperator = arguments.fetch(:seperator){", "}

    self.categories.pluck(:name).join(seperator)
  end

  def similar_items(arguments = {})
    user = arguments.fetch(:user) {nil}
    limit = arguments.fetch(:limit) {3}

    purchased_id_array = user.nil? ? [self.id] : [self.id] + user.items.ids #for removing base item and other user purchased items
    base_categories_id_array = self.categories.ids #get all category ids to query database

    #Query by base item's category ids, return the hash of EXACT matched items' id with their number of associated categories, and sorted by item's number of associated categories.
    p id_hash = Item.joins(:categories).where(categories: {id: base_categories_id_array}).group('items.id').having("count(categories.id) = #{base_categories_id_array.length}").order('count_categories_id desc').count('categories.id')
    # If's there's not enough, query for items of more categories than exatact match categories
    p "line19"
    p id_hash = Item.joins(:categories).where(categories: {id: base_categories_id_array}).group('items.id').having("count(categories.id) >= #{base_categories_id_array.length}").order("abs(COUNT(categories.id - #{base_categories_id_array.length})) asc").count('categories.id') if (id_hash.keys - purchased_id_array).length < limit
    p "line21"
    # If's there's not enough, query for items of ANY matching categories
    p id_hash = Item.joins(:categories).where(categories: {id: base_categories_id_array}).group('items.id').order('count_categories_id desc').count('categories.id') if (id_hash.keys - purchased_id_array).length < limit
    #At this point the hash can be further ordered by other factors, such as popularities
    Item.where( id: (id_hash.keys - purchased_id_array).first(limit) )
  end
end





#id_hash = Item.joins(:categories).where(:categories => {:id => item_categories_array}).group('items.id').order('count_categories_items_category_id desc').count('categories_items.category_id')

    #Query by item's category id, return the hash of EXACTLY matched items' id with their number of associated categories, and sorted by item's number of associated categories.

    # id_hash = Item.joins(:categories).where(categories: {id: base_categories_array}).group('items.id').having("count(categories.id) = #{base_categories_array.length}").order('count_categories_id desc').count('categories.id')


#@ids = [152,134]  #Find exact matches and return relations
#query = Item.joins(:categories).where(:categories => {:id => @ids}).group('items.id, items.name').having("count(categories_items.category_id) = #{@ids.length}")

#query = Item.joins(:categories).where(categories: {id: @ids}).group('items.id, items.name').having("count(category_id) = #{@ids.length}")  #working


#query = Item.joins(:categories).where(categories: {id: @ids}).group('items.id').having("count(categories_items.category_id) = #{@ids.length}").order('count_categories_id desc').count('categories.id')

#query = Item.joins(:categories).where(categories: {id: @ids}).group('items.id').having("count(categories_items.category_id) = #{@ids.length}").order('count_categories_id desc').count('categories.id')

#query = Item.joins(:categories).where(categories: {id: base_categories_array}).group('items.id').having("count(categories_items.category_id) = #{base_categories_array.length}").order('count_categories_id desc').count('categories.id')

#query = Item.joins(:categories).where(categories: {id: base_categories_array}).group('items.id').having("count(category_id) = #{base_categories_array.length}").order('count_categories_id desc').count('categories.id')

#Item.joins(:categories).where(categories: {id: base_categories_array}).group('items.id, categories').pluck(:id, :categories)  # These will return array as single item-category element, not aggregated.

#id_hash = Item.joins(:categories_items).where(categories_items: {category_id: base_categories_array}).group('items.id, categories_items.category_id').pluck(:id, :category_id)  #works for 2D array