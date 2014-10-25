require "nsobject"

module Crocoa
  class NSMutableArray < NSObject
    objc_method "init", nil, "id", "initialize"

    objc_method "count", nil, "NSUInteger"
    objc_method "addObject:", ["id"], "void", "<<"
    objc_method "objectAtIndex:", ["NSUInteger"], "id", "[]"
  end
end
