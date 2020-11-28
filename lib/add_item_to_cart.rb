require_relative 'create_sale_price_table'
require_relative 'take_user_input'
require_relative 'calculate_amount'

class CartItem
  include TakeUserInput
  attr_reader :orders

  def initialize
    @orders = []
  end

  def display_bill
    if !@orders.empty?
      checkout_bill = CalculateAmount.new(@orders);
      checkout_bill.display_items
    else
      puts "Pleace place an order."
    end
  end

  def add_item_to_cart(items)
    items_store = SalePrice.new
    items_keys = items_store.sale_price_list.keys

    @orders, unavailable_items = items.partition { |item| items_keys.include?(item.to_sym) }

    puts "\n#{unavailable_items.join(", ")} is unavailable now." if unavailable_items.length > 0
    
    display_bill
  end
end

cart = CartItem.new
cart.take_input