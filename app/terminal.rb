# frozen_string_literal: true

require_relative('./product')
require_relative('./cart')

# Terminal class
class Terminal
  attr_reader :cart
  def initialize
    @products = []
    @cart = Cart.new self
  end

  def add_product(product)
    @products << Product.new(product) unless product_added? product[:code]
  end

  def product_added?(code)
    @products.select { |product| product.code == code }.first
  end

  def bulk_scan(string)
    string.chars.each do |item|
      scan item
    end
  end

  def scan(code)
    @cart.add_cart_item(code)
  end

  def receipt
    "$#{@cart.total_with_tax}"
  end
end
