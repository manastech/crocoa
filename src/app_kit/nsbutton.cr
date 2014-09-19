require "./NSControl"

module Crocoa
  class NSButton < NSControl
    objc_method "title", nil, :NSString
    objc_method "setTitle:", [:NSString], nil, "title="
  end
end
