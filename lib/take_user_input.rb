module TakeUserInput
  def take_input
    puts "Please enter all the item name(seperated by a comma)"
    input = gets.chomp!

    if input.length > 0
      parse_str(input)
    else
      puts "Please place an order to continue"
      take_input
    end
  end

  def parse_str(str)
    items = str.downcase.split(",").collect { |item| item.gsub(/\s+/, "") }
    add_item_to_cart(items)
  end
end