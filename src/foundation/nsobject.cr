macro objc_class
  def initialize(s : UInt8*)
    super(s)
  end
end

macro objc_method_arg(value, type)
  {% if type == :NSUInteger %}
    {{value.id}}.to_nsuinteger
  {% else %}
    {% if type == :BOOL %}
      {{value.id}} == true
    {% else %}
      {{value.id}}
    {% end %}
  {% end %}
end

macro objc_init_method(method_name, crystal_method = nil)
  def self.{{(crystal_method || method_name).id}}
    self.new(nsclass.send_msg({{method_name}}))
  end
end

macro objc_method(method_name, args = nil, returnType = nil, crystal_method = nil)
  def {{(crystal_method || method_name).id}}(
    {% for i in 0 ... (args || [] of Symbol).length %}
    # ???? new lines breaks
    # ???? unable to extract type restriction on its own macro
      {{"arg#{i}".id}} {% if args[i] == :BOOL %}: Bool{% end %}{% end %})

    res = Crocoa.send_msg(self.to_objc, {{method_name}}
      {% for i in 0 ... (args || [] of Symbol).length %}
        , objc_method_arg({{"arg#{i}".id}}, args[i])
      {% end %}
    )

    # TODO wrap result. NSObject+ if id
    # TODO wrap result. specific class if specified
    # TODO wrap result if the class is exported from crystal and exposed to obj-c
    # ???? Posible to get all NSObject+ of the system? maybe using objc_class macro
    # ???? unable to elsif
    {% if returnType == :NSUInteger %}
      res.address
    {% else %}
      {% if returnType == :BOOL %}
        res.address != 0
      {% else %}
        {% if returnType == :id %}
          klass = NSClass.new(LibObjC.objc_msgSend(res, "class".to_sel.to_objc))
          if klass.name == "__NSCFString"
            Crocoa::NSString.new(res)
          else
            res
          end
        {% else %}
          {% if returnType == :unichar %}
            res.address.chr
          {% else %}
            self
          {% end %}
        {% end %}
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

    # ??? howto remove this. empty tuples for args seems not to be supported
    def alloc_init
      @obj = Crocoa.send_msg(nsclass.send_msg("alloc"), "init")
    end

    def alloc_init(init_method, arg)
      @obj = Crocoa.send_msg(nsclass.send_msg("alloc"), init_method, arg)
    end

    def finalize
      release
    end

    objc_method "retain"
    objc_method "release"
  end
end
