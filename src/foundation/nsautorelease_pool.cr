require "./nsobject"

module Crocoa
  class NSAutoreleasePool < NSObject
    objc_class

    def initialize
      alloc_init
    end
  end
end
