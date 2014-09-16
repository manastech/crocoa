macro objc_method(method_name)
  def {{method_name.id}}
    Crocoa.send_msg(self.to_objc, {{method_name.id.stringify}})
    self
  end
end

module Crocoa
  # represent instances that are defined in obj-c
  abstract class NSObject
    def self.nsclass
      NSClass.new self.to_s["Crocoa::".length..-1]
    end

    def nsclass
      self.class.nsclass
    end

    def initialize(pointer : UInt8*)
      @obj = pointer
      retain
    end

    def to_objc
      @obj.not_nil!
    end

    def send_msg(message, *args)
      Crocoa.send_msg(to_objc, message, *args)
    end

    def alloc_init(init_method, arg)
      @obj = nsclass.send_msg "alloc"
      initialize(send_msg(init_method, arg))
    end

    def finalize
      release
    end

    objc_method :retain
    objc_method :release
  end
end
