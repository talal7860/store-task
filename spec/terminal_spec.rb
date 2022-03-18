# frozen_string_literal: true

require_relative '../app/terminal'
require 'json'

RSpec.describe Terminal do
  describe 'Given test cases' do
    let(:terminal_products) { JSON.parse(File.read('./sample_products.json'), symbolize_names: true) }
    let(:terminal) { Terminal.new }
    before do
      terminal_products.each do |product|
        terminal.add_product product
      end
      terminal.cart.tax_percent = 10
    end
    it 'should return the $32.34 for BCDABEAAA' do
      terminal.bulk_scan 'BCDABEAAA'
      expect(terminal.receipt).to eq('$32.34')
    end
    it 'should return the $6.60 for CCCCCC' do
      terminal.bulk_scan 'CCCCCC'
      expect(terminal.receipt).to eq('$6.60')
    end
    it 'should return the $14.74 for ABCD' do
      terminal.bulk_scan 'ABCD'
      expect(terminal.receipt).to eq('$14.74')
    end
    it 'should return the $14.74 for ABECDE' do
      terminal.bulk_scan 'ABECDE'
      expect(terminal.receipt).to eq('$16.94')
    end
  end
end
