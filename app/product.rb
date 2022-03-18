# frozen_string_literal: true

# Product Class
class Product
  attr_reader :code, :price_cents, :promotion
  def initialize(code:, price_cents:, promotion:)
    @price_cents = price_cents
    @promotion = promotion
    @code = code
  end

  def promotion?(promotion_type)
    @promotion[:type] == promotion_type
  end
end
