module ItemsHelper

  @promotion_items_ids = [1310, 1598, 1601]  #Please put the items id for promotion.

  def category_names_string(arguments = {})
    seperator = arguments.fetch(:seperator){", "}

    self.categories.pluck(:name).join(seperator)
  end

  def similar_items(arguments = {})
    p @promotion_items_ids
    user = arguments.fetch(:user) {nil}
    limit = arguments.fetch(:limit) {3}
    p "line12, self id:#{self.id}, self.categories.ids: #{self.categories.ids}"
    purchased_id_array = user.nil? ? [self.id] : [self.id] + user.items.ids
    query_size = limit + purchased_id_array.length
    base_categories_id_array = self.categories.ids
    p "line16, item_array exist? #{!!defined?(item_array)}, query_size: #{query_size}"
    item_array  = Item.with_exact_categories(category_ids: base_categories_id_array, limit: query_size)
    "line18, item_array size: #{item_array.size}, query_size: #{query_size}. Is item_array.length < query_size? #{item_array.length < query_size}, first 3 obj in the item_array: #{item_array.first.id unless item_array.first.nil?}, #{item_array.second.id unless item_array.second.nil?}, #{item_array.third.id unless item_array.third.nil?}"
    item_array += Item.with_more_categories(category_ids: base_categories_id_array, limit: query_size) if item_array.length < query_size
    p "line 20, item_array size: #{item_array.size}, query_size: #{query_size}, first 3 obj in the item_array: #{item_array.first.id unless item_array.first.nil?}, #{item_array.second.id unless item_array.second.nil?}, #{item_array.third.id unless item_array.third.nil?}"
    item_array += Item.matched_any_categories(category_ids: base_categories_id_array, limit: query_size) if item_array.length < query_size
    p "line 25, item_array size: #{item_array.size}, query_size: #{query_size}, first 3 obj in the item_array: #{item_array.first.id unless item_array.first.nil?}, #{item_array.second.id unless item_array.second.nil?}, #{item_array.third.id unless item_array.third.nil?}"
    item_array += Item.suggest_promotions(promotion_items_ids: @promotion_items_ids, limit: query_size) if item_array.length < query_size
    (item_array - Item.where( id: purchased_id_array)).first(limit)
  end
end
