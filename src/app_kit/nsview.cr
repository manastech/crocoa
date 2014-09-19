require "./NSResponder"

module Crocoa
  class NSView < NSResponder
    objc_method "initWithFrame:", [:NSRect], :id, "initialize"

    objc_method "addSubview:", [:NSView], :void, "<<"
  end
end
