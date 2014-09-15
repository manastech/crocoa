module Crocoa
  class NSClass
    property :obj

    def initialize(c : UInt8*)
      @obj = c
    end

    def initialize(className : String)
      @obj = LibObjC.getClass(className)
    end

    def name
      String.new(LibObjC.class_getName(@obj))
    end
  end
end
