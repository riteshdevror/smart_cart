require 'spec_helper'
require_relative '../../lib/smart_cart/delivery_rule'

RSpec.describe SmartCart::DeliveryRule do
  before do
    described_class.clear_all
  end

  describe '#initialize' do
    it 'sets threshold and cost correctly' do
      rule = described_class.new(50, 2.95)

      expect(rule.threshold).to eq(50)
      expect(rule.cost).to eq(2.95)
    end

    it 'stores the instance in the in-memory store' do
      rule = described_class.new(90, 0.0)
      expect(described_class.all).to include(rule)
    end
  end

  describe '.find_by' do
    it 'finds the correct rule by threshold' do
      rule1 = described_class.new(50, 2.95)
      rule2 = described_class.new(90, 0.0)

      expect(described_class.find_by(threshold: 90)).to eq(rule2)
    end

    it 'returns nil for unmatched search' do
      described_class.new(50, 2.95)
      expect(described_class.find_by(threshold: 100)).to be_nil
    end
  end
end
