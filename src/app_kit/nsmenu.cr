module Crocoa
  class NSMenu < NSObject
    objc_method "initWithTitle:", [:NSString], :id, "initialize"

    objc_method "addItem:", [:NSMenuItem], :void, "<<"
  end
end
