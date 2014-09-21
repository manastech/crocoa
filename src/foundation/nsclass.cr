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

    def superclass
      s = LibObjC.class_getSuperclass(@obj)
      unless s.nil?
        NSClass.new(s)
      else
        nil
      end
    end

    def send_msg(message, *args)
      Crocoa.send_msg(@obj, message, *args)
    end

    def to_s(io)
      io << name
    end

    def self.all
      total = LibObjC.objc_getClassList(nil, 0u64)
      buffer = Pointer(LibObjC::Class).malloc(total)
      LibObjC.objc_getClassList(buffer, total)
      buffer
        .as_enumerable(total)
        .map { |x| NSClass.new x }
        .each do |nsclass|
        yield nsclass
      end
    end
  end
end
