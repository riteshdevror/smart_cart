module SmartCart
  class DeliveryRule
    include SmartCart::InMemoryStore

    attr_reader :threshold, :cost

    def initialize(threshold, cost)
      @threshold = threshold
      @cost = cost
      super()
    end
  end
end