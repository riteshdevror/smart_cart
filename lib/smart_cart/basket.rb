module SmartCart
  class Basket
    include SmartCart::InMemoryStore

    def initialize(products:, delivery_rules:, offers: [])
      @catalogue = products.map { |p| [p.code, p] }.to_h
      @delivery_rules = delivery_rules.sort_by(&:threshold)
      @offers = offers
      @items = Hash.new(0)
      super()
    end

    def add(product_code)
      raise ArgumentError, "Invalid product code" unless @catalogue.key?(product_code)
      @items[product_code] += 1
    end

    def total
      subtotal = calculate_subtotal
      discount = apply_offers
      delivery = calculate_delivery(subtotal - discount)

      total_amount = subtotal - discount + delivery
      format_currency(total_amount)
    end

    def display_basket
      puts "\nCurrent Basket:"
      @items.each do |code, qty|
        product = @catalogue[code]
        puts "#{product.name} (#{code}) - Qty: #{qty} - $#{product.price} each"
      end
    end

    private

    def calculate_subtotal
      @items.sum do |code, quantity|
        product = @catalogue[code]
        product.price * quantity
      end
    end

    def apply_offers
      @offers.sum do |offer|
        offer.apply(basket_items)
      end
    end

    def basket_items
      @items.map { |code, quantity| [@catalogue[code], quantity] }.to_h
    end

    def calculate_delivery(total_after_discount)
      applicable_rule = @delivery_rules.reverse.find { |rule| total_after_discount >= rule.threshold }
      applicable_rule ? applicable_rule.cost : 0
    end

    def format_currency(amount)
      "$#{'%.2f' % amount.round(2)}"
    end
  end
end
