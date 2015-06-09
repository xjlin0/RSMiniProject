module ItemsHelper

  def category_names_string(arguments = {})
    seperator = arguments.fetch(:seperator){", "}

    self.categories.pluck(:name).join(seperator)
  end

  def similar_items(arguments = {})
    user = arguments.fetch(:user) {nil}
    limit = arguments.fetch(:limit) {3}
    p "line12"
    purchased_id_array = user.nil? ? [self.id] : [self.id] + user.items.ids
    base_categories_id_array = self.categories.ids
    p "line15"
    p item_array  = Item.with_exact_categories(category_ids: base_categories_id_array, limit: limit+purchased_id_array.length)
    p "line17"
    p item_array += Item.with_more_categories(category_ids: base_categories_id_array, limit: limit+purchased_id_array.length) if (item_array.length - purchased_id_array.length) < limit
    p "line 19"
    p item_array += Item.with_any_categories(category_ids: base_categories_id_array, limit: limit+purchased_id_array.length) if (item_array.length - purchased_id_array.length) < limit
    (item_array - Item.where( id: purchased_id_array)).first(limit)
  end
end
