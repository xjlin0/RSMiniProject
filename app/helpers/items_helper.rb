module ItemsHelper

  def category_names_string(arguments = {})
    seperator = arguments.fetch(:seperator){", "}
    self.categories.pluck(:name).join(seperator)
  end

  def similar_items(user=nil, limit=3, seperator=" | ")
    item_categories_array = self.categories.pluck(:id) #get all category ids to query database
    #Query by item's category id, return matched items' id with any matching of the category, and sort by item's number of categories.
    p id_hash = Item.joins(:categories).where('categories_items.category_id': item_categories_array).group('items.id').order('count_categories_items_category_id desc').count('categories_items.category_id')
    purchased_ids = user.nil? ? [self.id] : [self.id] + user.items.pluck(:id) #removed user purchased items
    Item.where( id: (id_hash.keys - purchased_ids).first(limit) )
  end
end