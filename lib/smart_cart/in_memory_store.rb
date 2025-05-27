module SmartCart
  module InMemoryStore
    def self.included(base)
      base.extend(ClassMethods)
      base.instance_variable_set(:@records, [])
    end

    module ClassMethods
      def all
        @records
      end

      def clear_all
        @records.clear
      end

      def find_by(attrs = {})
        @records.find do |record|
          attrs.all? { |key, value| record.send(key) == value }
        end
      end
    end

    def initialize
      self.class.instance_variable_get(:@records) << self
    end
  end
end
