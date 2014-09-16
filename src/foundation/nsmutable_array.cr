require "nsobject"

module Crocoa
  class NSMutableArray < NSObject
    def initialize
      alloc_init
    end

    objc_method "count", nil, :NSUInteger
    objc_method "addObject:", [:id], :void, "<<"
    objc_method "objectAtIndex:", [:NSUInteger], :id, "[]"
  end
end
