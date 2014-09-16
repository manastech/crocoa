module Crocoa
  class NSString < NSObject
    def initialize(s : String)
      alloc_init "initWithUTF8String:", s.cstr
    end

    def to_s(io)
      io << String.new(send_msg "UTF8String")
    end

    objc_method "length", nil, :NSUInteger
    objc_method "characterAtIndex:", [:NSUInteger], :unichar, "[]"

    # def [](index : Int)
    #   msgSend("characterAtIndex:", index.to_nsuinteger).address.chr
    # end

  end
end
