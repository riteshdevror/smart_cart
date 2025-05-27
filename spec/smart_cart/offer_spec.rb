require 'spec_helper'
require_relative '../../lib/smart_cart/in_memory_store'
require_relative '../../lib/smart_cart/product'
require_relative '../../lib/smart_cart/offer'

RSpec.describe SmartCart::Offer do
  before do
    SmartCart::Offer.clear_all
    SmartCart::Product.clear_all
  end

  let!(:product) { SmartCart::Product.new(code: "R01", name: "Red Widget", price: 30.00) }

  describe '#initialize' do
    it 'creates an offer and stores it in memory' do
      offer = SmartCart::Offer.new(product_code: "R01", min_qty: 2, discount_type: :percentage_on_pair, discount_value: 50)
      expect(SmartCart::Offer.all).to include(offer)
    end
  end

  describe '#apply' do
    context 'when basket has eligible items for percentage_on_pair' do
      it 'applies 50% off for each pair' do
        offer = SmartCart::Offer.new(product_code: "R01", min_qty: 2, discount_type: :percentage_on_pair, discount_value: 50)
        basket_items = { product => 4 }

        discount = offer.apply(basket_items)
        expect(discount).to eq(30.0)
      end

      it 'applies discount only to full pairs' do
        offer = SmartCart::Offer.new(product_code: "R01", min_qty: 2, discount_type: :percentage_on_pair, discount_value: 50)
        basket_items = { product => 3 }

        discount = offer.apply(basket_items)
        expect(discount).to eq(15.0)
      end
    end

    context 'when quantity is below minimum' do
      it 'does not apply any discount' do
        offer = SmartCart::Offer.new(product_code: "R01", min_qty: 2, discount_type: :percentage_on_pair, discount_value: 50)
        basket_items = { product => 1 }

        expect(offer.apply(basket_items)).to eq(0)
      end
    end

    context 'when product is not in basket' do
      it 'returns 0 discount' do
        offer = SmartCart::Offer.new(product_code: "R01", min_qty: 2, discount_type: :percentage_on_pair, discount_value: 50)
        other_product = SmartCart::Product.new(code: "B01", name: "Blue Widget", price: 10.00)
        basket_items = { other_product => 2 }

        expect(offer.apply(basket_items)).to eq(0)
      end
    end

    context 'when discount type is unrecognized' do
      it 'returns 0' do
        offer = SmartCart::Offer.new(product_code: "R01", min_qty: 2, discount_type: :unknown_type, discount_value: 50)
        basket_items = { product => 4 }

        expect(offer.apply(basket_items)).to eq(0)
      end
    end
  end
end
