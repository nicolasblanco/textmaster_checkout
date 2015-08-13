require "item"

class Checkout
  attr_reader :items, :rules

  def initialize(rules: [])
    @items = []
    @rules = rules
  end

  def scan(item)
    @items << item

    true
  end

  def total
    @items.inject(0) { |m, o| m += o.price } + total_rules
  end

  def total_rules
    @rules.inject(0) do |current_total, rule_class|
      rule = rule_class.new(@items)
      current_total += rule.total if rule.apply?

      current_total
    end
  end
end
