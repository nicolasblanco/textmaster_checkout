require "item"
require "rules/buy_one_get_one_fruit_tea"

RSpec.describe Rules::BuyOneGetOneFruitTea do
  context 'no pack of fruit tea in items' do
    it 'does not apply' do
      items = [Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1')]

      rule = Rules::BuyOneGetOneFruitTea.new(items)
      expect(rule).not_to be_apply
    end
  end

  context 'with at least a pack of fruit tea in items' do
    let(:items) { [Item.new(price: 5.00, name: 'Apple', product_code: 'AP1'),
                   Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1'),
                   Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1'),
                   Item.new(price: 11.23, name: 'Coffee', product_code: 'CF1'),
                   Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1')] }

    let(:rule) { Rules::BuyOneGetOneFruitTea.new(items) }

    it 'applies' do
      expect(rule).to be_apply
    end

    it 'discounts for the number of packs in items' do
      expect(rule.total).to eq(-3.11)
    end
  end
end
