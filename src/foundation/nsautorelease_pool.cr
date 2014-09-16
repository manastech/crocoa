require "./nsobject"

module Crocoa
  class NSAutoreleasePool < NSObject
    def initialize
      alloc_init
    end
  end
end
