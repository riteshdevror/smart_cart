module SmartCart
  class Product
    include SmartCart::InMemoryStore

    attr_accessor :code, :name, :price

    def initialize(code:, name:, price:)
      @code = code
      @name = name
      @price = price
      super()
    end
  end
end
