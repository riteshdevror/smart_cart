module SmartCart
  class Offer
    include SmartCart::InMemoryStore

    def initialize(product_code:, min_qty:, discount_type:, discount_value:)
      @product_code = product_code
      @min_qty = min_qty
      @discount_type = discount_type
      @discount_value = discount_value
      super()
    end

    def apply(basket_items)
      product, qty = basket_items.find { |p, _| p.code == @product_code }
      return 0 unless product && qty >= @min_qty

      case @discount_type
      when :percentage_on_pair
        eligible_pairs = qty / 2
        discount_per_pair = product.price * (@discount_value / 100.0)
        eligible_pairs * discount_per_pair
      else
        0
      end
    end
  end
end
