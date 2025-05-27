require 'spec_helper'

RSpec.describe SmartCart::Basket do
  before do
    SmartCart::Product.clear_all
    SmartCart::DeliveryRule.clear_all
    SmartCart::Offer.clear_all

    # Add this block after clearing!
    SmartCart::Product.new(code: "R01", name: "Red Widget", price: 32.95)
    SmartCart::Product.new(code: "B01", name: "Blue Widget", price: 7.95)
    SmartCart::DeliveryRule.new(0, 4.95)
    SmartCart::DeliveryRule.new(50, 2.95)
    SmartCart::DeliveryRule.new(90, 0.00)
  end

  let(:products) { SmartCart::Product.all }
  let(:delivery_rules) { SmartCart::DeliveryRule.all }

  context "without offers" do
    it "adds items and calculates subtotal and delivery" do
      basket = described_class.new(products: products, delivery_rules: delivery_rules)

      basket.add("R01")
      basket.add("B01")

      expect(basket.total).to eq("$45.85")
    end

    it "applies correct delivery based on thresholds" do
      basket = described_class.new(products: products, delivery_rules: delivery_rules)
      3.times { basket.add("R01") }

      expect(basket.total).to eq("$98.85")
    end

    it "raises error on invalid product" do
      basket = described_class.new(products: products, delivery_rules: delivery_rules)
      expect { basket.add("INVALID") }.to raise_error(ArgumentError, "Invalid product code")
    end
  end

  context "with offers" do
    before do
      SmartCart::Offer.new(
        product_code: "R01",
        min_qty: 2,
        discount_type: :percentage_on_pair,
        discount_value: 50
      )
    end

    it "applies percentage_on_pair discount correctly" do
      basket = described_class.new(products: products, delivery_rules: delivery_rules, offers: SmartCart::Offer.all)

      basket.add("R01")
      basket.add("R01")

      expect(basket.total).to eq("$54.38")
    end
  end
end
