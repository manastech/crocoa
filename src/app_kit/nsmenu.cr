module Crocoa
  class NSMenu < NSObject
    def initialize(title : String)
      alloc_init "initWithTitle:", NSString.new(title)
    end
  end
end
