module Crocoa
  class NSString < NSObject
    def initialize(s : String)
      alloc_init "initWithUTF8String:", s.cstr
    end

    def to_s(io)
      io << String.new(send_msg "UTF8String")
    end

    objc_method "length", :NSUInteger

    # def [](index : Int)
    #   msgSend("characterAtIndex:", index.to_nsuinteger).address.chr
    # end

  end
end
