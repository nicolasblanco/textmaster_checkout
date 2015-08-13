class Item
  attr_reader :price, :name, :product_code

  def initialize(price:, name:, product_code:)
    @price = price
    @name = name
    @product_code = product_code
  end
end
