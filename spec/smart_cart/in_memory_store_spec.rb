require 'spec_helper'
require_relative '../../lib/smart_cart/in_memory_store'

RSpec.describe SmartCart::InMemoryStore do
  let(:dummy_class) do
    Class.new do
      include SmartCart::InMemoryStore

      attr_accessor :name, :value

      def initialize(name:, value:)
        @name = name
        @value = value
        super()
      end
    end
  end

  before do
    dummy_class.clear_all
  end

  describe 'record storage' do
    it 'stores instances in the class-level record array' do
      item = dummy_class.new(name: 'Test', value: 123)
      expect(dummy_class.all).to include(item)
    end

    it 'clears all records' do
      dummy_class.new(name: 'A', value: 1)
      dummy_class.new(name: 'B', value: 2)

      expect(dummy_class.all.size).to eq(2)

      dummy_class.clear_all
      expect(dummy_class.all).to be_empty
    end
  end

  describe '.find_by' do
    it 'finds a record by attributes' do
      match = dummy_class.new(name: 'X', value: 10)
      dummy_class.new(name: 'Y', value: 20)

      result = dummy_class.find_by(name: 'X', value: 10)
      expect(result).to eq(match)
    end

    it 'returns nil when no match is found' do
      dummy_class.new(name: 'X', value: 10)

      expect(dummy_class.find_by(name: 'Z')).to be_nil
    end
  end
end
