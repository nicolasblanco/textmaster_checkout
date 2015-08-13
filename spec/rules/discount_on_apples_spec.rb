require "item"
require "rules/discount_on_apples"

RSpec.describe Rules::DiscountOnApples do
  context 'when there is less than 3 apples' do
    it 'does not apply' do
      items = [Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1'),
               Item.new(price: 5.00, name: 'Apple', product_code: 'AP1'),
               Item.new(price: 5.00, name: 'Apple', product_code: 'AP1')]

      rule = Rules::DiscountOnApples.new(items)
      expect(rule).not_to be_apply
    end
  end

  context 'with at least 3 apples in items' do
    let(:items) { [Item.new(price: 5.00, name: 'Apple', product_code: 'AP1'),
                   Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1'),
                   Item.new(price: 5.00, name: 'Apple', product_code: 'AP1'),
                   Item.new(price: 11.23, name: 'Coffee', product_code: 'CF1'),
                   Item.new(price: 5.00, name: 'Apple', product_code: 'AP1')] }

    let(:rule) { Rules::DiscountOnApples.new(items) }

    it 'applies' do
      expect(rule).to be_apply
    end

    it 'discounts for the number of apples in items' do
      expect(rule.total).to eq(-1.50)
    end
  end
end
