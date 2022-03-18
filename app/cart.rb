# frozen_string_literal: true

require_relative './cart_item'

# Cart class
# Class for adding cart items, calculating tax and total
class Cart
  attr_accessor :tax_percent
  attr_reader :items
  def initialize(terminal)
    @items = []
    @terminal = terminal
    @tax_percent = 0
  end

  def item_added?(code)
    @items.select { |item| item.product.code == code }.first
  end

  def add_cart_item(item)
    product = @terminal.product_added?(item)
    return unless product

    cart_item = item_added?(item)
    if cart_item
      cart_item.quantity += 1
      cart_item.price_cents += product.price_cents
    else
      cart_item = CartItem.new product
      @items.push cart_item
    end
    cart_item.settle_groups
  end

  def settle_combination
    @items.select { |item| item.product.promotion?('combination') }.each do |item|
      combination_item = item_added?(item.product&.promotion&.dig(:product_code))
      next unless combination_item

      quantity = combination_item.quantity - item.quantity
      calc_quantity = quantity.positive? ? item.quantity : combination_item.quantity
      combination_item.price_cents -= combination_item.product.price_cents * calc_quantity
      combination_item.price_cents += item.product.promotion[:price_cents] * calc_quantity
    end
  end

  def tax(total)
    total * (@tax_percent.to_f / 100)
  end

  def total_with_tax
    settle_combination
    total_price_cents = @items.reduce(0) do |total, item|
      total + item.price_cents
    end
    total_with_tax = total_price_cents + tax(total_price_cents)
    '%.2f' % (total_with_tax / 100)
  end
end
