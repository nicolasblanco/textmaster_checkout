require "item"
require "rules/discount_on_apples"

RSpec.describe Rules::DiscountOnApples do
  context 'when there is less than 3 apples' do
    it 'does not apply' do
      items = [fruit_tea_item, apple_item, apple_item]

      rule = Rules::DiscountOnApples.new(items)
      expect(rule).not_to be_apply
    end
  end

  context 'with at least 3 apples in items' do
    let(:items) { [apple_item, fruit_tea_item, apple_item, coffee_item, apple_item] }

    let(:rule) { Rules::DiscountOnApples.new(items) }

    it 'applies' do
      expect(rule).to be_apply
    end

    it 'discounts for the number of apples in items' do
      expect(rule.total).to eq(-1.50)
    end
  end
end
