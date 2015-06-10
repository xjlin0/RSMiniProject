module ItemsHelper

  @@promotion_items_ids  = [1310, 1598, 1601]  #Please put the items id for promotion.
  @@off_shelve_items_ids = [0]                 #Please put the items stopped for sale.

  def category_names_string(arguments = {})
    seperator = arguments.fetch(:seperator){", "}

    self.categories.pluck(:name).join(seperator)
  end

  def similar_items(arguments = {})
    user  = arguments.fetch(:user) {nil}
    limit = arguments.fetch(:limit) {3}
    base_categories_id_array = self.categories.ids
    excluded_item_ids = user.items.ids + @@off_shelve_items_ids

    item_array  = Item.with_exact_categories(category_ids: base_categories_id_array, limit: limit, minus: excluded_item_ids)
    item_array += Item.matched_any_categories(category_ids: base_categories_id_array, limit: limit, minus: excluded_item_ids) if item_array.length < limit
    item_array += Item.suggest_promotions(promotion_items_ids: @@promotion_items_ids, limit: limit, minus: excluded_item_ids) if item_array.length < limit
    item_array.first(limit)
  end
end
