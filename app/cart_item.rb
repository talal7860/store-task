# frozen_string_literal: true

# Cart Item class
class CartItem
  attr_accessor :quantity, :price_cents
  attr_reader :product

  def initialize(product)
    @product = product
    @quantity = 1
    @price_cents = product.price_cents
  end

  def settle_groups
    return unless @product.promotion?('group')

    group_count = (@quantity / @product.promotion[:quantity]).floor
    left_over = quantity % @product.promotion[:quantity]
    return unless group_count.positive?

    @price_cents = @product.promotion[:price_cents] * group_count
    @price_cents += @product.price_cents * left_over
  end
end
