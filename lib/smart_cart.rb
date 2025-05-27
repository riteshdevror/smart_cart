require_relative 'smart_cart/in_memory_store'
require_relative 'smart_cart/product'
require_relative 'smart_cart/offer'
require_relative 'smart_cart/delivery_rule'
require_relative 'smart_cart/basket'

module SmartCart
  def self.load_data
    # Clear all records first
    [Product, Offer, DeliveryRule].each(&:clear_all)

    # Products
    Product.new(code: "R01", name: "Red Widget", price: 32.95)
    Product.new(code: "G01", name: "Green Widget", price: 24.95)
    Product.new(code: "B01", name: "Blue Widget", price: 7.95)

    # Delivery Rules
    DeliveryRule.new(90, 0.00)
    DeliveryRule.new(50, 2.95)
    DeliveryRule.new(0, 4.95)

    # Offers
    SmartCart::Offer.new(
      product_code: "R01",
      min_qty: 2,
      discount_type: :percentage_on_pair,
      discount_value: 50
    )
  end
end
