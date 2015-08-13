require 'rules/base'

module Rules
  class BuyOneGetOneFruitTea < Base
    def number_of_fruit_tea_items
      @number_of_fruit_tea_items ||= @items.map(&:product_code).count('FR1')
    end

    def apply?
      number_of_fruit_tea_items > 1
    end

    def total
      product_discount = @items.find { |i| i.product_code == 'FR1' }.price
      number_of_packs = number_of_fruit_tea_items / 2

      number_of_packs * product_discount * -1
    end
  end
end
