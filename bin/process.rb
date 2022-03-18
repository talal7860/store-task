#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative('../app/terminal')
require('json')

terminal = Terminal.new
terminal.cart.tax_percent = 10
terminal_products = JSON.parse(File.read('./sample_products.json'), symbolize_names: true)
terminal_products.each do |product|
  terminal.add_product product
end
terminal.bulk_scan(ARGV[0])

puts('Total', terminal.receipt)
