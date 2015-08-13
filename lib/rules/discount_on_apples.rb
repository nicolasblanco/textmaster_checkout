require 'rules/base'

module Rules
  class DiscountOnApples < Base
    DISCOUNT_ON_APPLE = 0.5

    def number_of_apples_items
      @number_of_apples_items ||= @items.map(&:product_code).count('AP1')
    end

    def apply?
      number_of_apples_items >= 3
    end

    def total
      number_of_apples_items * DISCOUNT_ON_APPLE * -1
    end
  end
end
