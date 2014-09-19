module Crocoa
  class NSTextField < NSControl
    def value
      self.string_value
    end

    def value=(v)
      self.string_value = v
    end
  end
end
