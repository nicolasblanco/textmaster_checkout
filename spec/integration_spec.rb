require "checkout"
require "rules/buy_one_get_one_fruit_tea"
require "rules/discount_on_apples"

RSpec.describe "Integration" do
  let(:checkout) { Checkout.new(rules: [Rules::BuyOneGetOneFruitTea, Rules::DiscountOnApples]) }

  it "applies the discount 'buy-one-get-one-fruit-tea'" do
    checkout.scan(fruit_tea_item)
    checkout.scan(apple_item)
    checkout.scan(fruit_tea_item)
    checkout.scan(coffee_item)

    expect(checkout.total).to eq(19.34) # Not 22.25 like in the statement! There are 2 fruit tea, so one free, the CEO is happy.
  end

  it "applies the discount 'buy-one-get-one-fruit-tea' the Return" do
    checkout.scan(fruit_tea_item)
    checkout.scan(fruit_tea_item)

    expect(checkout.total).to eq(3.11)
  end

  it "applies the discount on apples" do
    checkout.scan(apple_item)
    checkout.scan(apple_item)
    checkout.scan(fruit_tea_item)
    checkout.scan(apple_item)

    expect(checkout.total).to eq(16.61)
  end
end
