module Rules
  class Base
    def initialize(items)
      @items = items
    end

    def apply?
      raise NotImplementedError
    end

    def total
      raise NotImplementedError
    end
  end
end
