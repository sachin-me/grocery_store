require_relative 'create_sale_price_table'
require_relative 'take_user_input'

class CartItem
  include TakeUserInput
  attr_reader :orders

  def initialize
    @orders = []
  end

  def add_item_to_cart(items)
    items_store = SalePrice.new
    items_keys = items_store.sale_price_list.keys

    @orders, unavailable_items = items.partition { |item| items_keys.include?(item.to_sym) }

    puts "\n#{unavailable_items.join(", ")} is unavailable now." if unavailable_items.length > 0

  end
end

cart = CartItem.new
cart.take_input