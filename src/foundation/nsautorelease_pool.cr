require "./nsobject"

module Crocoa
  class NSAutoreleasePool < NSObject
    objc_method "init", nil, "id", "initialize"
  end
end
