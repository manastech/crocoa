module Crocoa
  class NSClass
    property :obj

    def initialize(c : UInt8*)
      @obj = c
    end

    def initialize(className : String)
      @obj = LibObjC.objc_getClass(className)
    end

    def name
      String.new(LibObjC.class_getName(@obj))
    end

    def send_msg(message, *args)
      Crocoa.send_msg(@obj, message, *args)
    end
  end
end
