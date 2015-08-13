require "checkout"
require "rules/buy_one_get_one_fruit_tea"
require "rules/discount_on_apples"

RSpec.describe "Integration" do
  let(:checkout) { Checkout.new(rules: [Rules::BuyOneGetOneFruitTea, Rules::DiscountOnApples]) }

  it "applies the discount 'buy-one-get-one-fruit-tea'" do
    checkout.scan(Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1'))
    checkout.scan(Item.new(price: 5.00, name: 'Apple', product_code: 'AP1'))
    checkout.scan(Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1'))
    checkout.scan(Item.new(price: 11.23, name: 'Coffee', product_code: 'CF1'))

    expect(checkout.total).to eq(19.34)
  end

  it "applies the discount 'buy-one-get-one-fruit-tea' the Return" do
    checkout.scan(Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1'))
    checkout.scan(Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1'))

    expect(checkout.total).to eq(3.11)
  end

  it "applies the discount on apples" do
    checkout.scan(Item.new(price: 5.00, name: 'Apple', product_code: 'AP1'))
    checkout.scan(Item.new(price: 5.00, name: 'Apple', product_code: 'AP1'))
    checkout.scan(Item.new(price: 3.11, name: 'Fruit tea', product_code: 'FR1'))
    checkout.scan(Item.new(price: 5.00, name: 'Apple', product_code: 'AP1'))

    expect(checkout.total).to eq(16.61)
  end

end
