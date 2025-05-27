require 'spec_helper'
require_relative '../../lib/smart_cart/in_memory_store'
require_relative '../../lib/smart_cart/product'

RSpec.describe SmartCart::Product do
  before do
    SmartCart::Product.clear_all
  end

  describe '#initialize' do
    it 'creates a product with code, name, and price' do
      product = SmartCart::Product.new(code: "R01", name: "Red Widget", price: 32.95)

      expect(product.code).to eq("R01")
      expect(product.name).to eq("Red Widget")
      expect(product.price).to eq(32.95)
    end

    it 'adds the product to in-memory store' do
      product = SmartCart::Product.new(code: "G01", name: "Green Widget", price: 24.95)
      expect(SmartCart::Product.all).to include(product)
    end
  end

  describe '#attr_accessor' do
    it 'allows reading and writing of code, name, and price' do
      product = SmartCart::Product.new(code: "B01", name: "Blue Widget", price: 7.95)

      product.code = "B02"
      product.name = "Black Widget"
      product.price = 9.99

      expect(product.code).to eq("B02")
      expect(product.name).to eq("Black Widget")
      expect(product.price).to eq(9.99)
    end
  end
end
