require 'spec_helper'
require_relative '../../lib/smart_cart'

RSpec.describe SmartCart do
  before do
    SmartCart::Product.clear_all
    SmartCart::Offer.clear_all
    SmartCart::DeliveryRule.clear_all
    SmartCart.load_data
  end

  describe '.load_data' do
    it 'loads all products into memory' do
      expect(SmartCart::Product.all.size).to eq(3)

      codes = SmartCart::Product.all.map(&:code)
      expect(codes).to contain_exactly("R01", "G01", "B01")
    end

    it 'loads all delivery rules in memory' do
      expect(SmartCart::DeliveryRule.all.size).to eq(3)

      thresholds = SmartCart::DeliveryRule.all.map(&:threshold)
      expect(thresholds).to contain_exactly(0, 50, 90)
    end

    it 'loads one offer into memory' do
      expect(SmartCart::Offer.all.size).to eq(1)

      offer = SmartCart::Offer.all.first
      expect(offer.instance_variable_get(:@product_code)).to eq("R01")
      expect(offer.instance_variable_get(:@min_qty)).to eq(2)
      expect(offer.instance_variable_get(:@discount_type)).to eq(:percentage_on_pair)
      expect(offer.instance_variable_get(:@discount_value)).to eq(50)
    end
  end
end
