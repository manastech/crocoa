macro objc_method_arg(value, type)
  {% if type == :NSUInteger %}
    {{value.id}}.to_nsuinteger
  {% else %}
    {{value.id}}
  {% end %}
end

macro objc_method(method_name, args = nil, returnType = nil, crystal_method = nil)
  def {{(crystal_method || method_name).id}}(
    {% for i in 0 ... (args || [] of Symbol).length %}
      {{"arg#{i}".id}}
    {% end %}
    )

    res = Crocoa.send_msg(self.to_objc, {{method_name.id.stringify}}
      {% for i in 0 ... (args || [] of Symbol).length %}
        , {{"arg#{i}".id}}
      {% end %}
    )

    {% if returnType == :NSUInteger %}
      res.address
    {% else %}
      {% if returnType == :unichar %}
        res.address.chr
      {% else %}
        self
      {% end %}
    {% end %}
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

    objc_method "retain"
    objc_method "release"
  end
end
