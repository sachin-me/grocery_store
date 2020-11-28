require_relative 'create_sale_price_table'

class CalculateAmount
  def initialize(items = [])
    @items = items
    @total_purchased_amount = 0
    @total_saved_amount = 0
    @sale_price_list = SalePrice.new.sale_price_list
    @purchased_items_quantity = @items.to_h
  end

  def calculate_amount_without_sale
    @purchased_items_quantity.keys.reduce(0) { |sum, item| 
      cnvrt_item_to_sym = @sale_price_list[item.to_sym]
      sum += @purchased_items_quantity[item] * cnvrt_item_to_sym[:unit_price]
    }
  end

  def calculate_discount_price
    @purchased_items_quantity.keys.reduce(0) { |sum, item| sum += calculate_item_price(item.to_sym) }
  end

  def calculate_saved_amount
    calculate_amount_without_sale - calculate_discount_price
  end

  def calculate_item_price(item)
    item[:sale_quantity] >= 1 ?
     ((@purchased_items_quantity[item] / item[:sale_quantity]) * item[:sale_price]) + (
       (@purchased_items_quantity[item.to_i] % item[:sale_quantity]) * item[:unit_price]
     )
   : (@purchased_items_quantity[item] * item[:unit_price])
  end

  
end