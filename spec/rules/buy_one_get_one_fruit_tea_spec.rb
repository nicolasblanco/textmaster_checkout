require "item"
require "rules/buy_one_get_one_fruit_tea"

RSpec.describe Rules::BuyOneGetOneFruitTea do
  context 'no pack of fruit tea in items' do
    it 'does not apply' do
      items = [fruit_tea_item]

      rule = Rules::BuyOneGetOneFruitTea.new(items)
      expect(rule).not_to be_apply
    end
  end

  context 'with at least a pack of fruit tea in items' do
    let(:items) { [apple_item, fruit_tea_item, fruit_tea_item, coffee_item, fruit_tea_item] }

    let(:rule) { Rules::BuyOneGetOneFruitTea.new(items) }

    it 'applies' do
      expect(rule).to be_apply
    end

    it 'discounts for the number of packs in items' do
      expect(rule.total).to eq(-3.11)
    end
  end
end
