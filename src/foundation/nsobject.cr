module Crocoa
  # represent instances that are defined in obj-c
  abstract class NSObject
    macro objc_class
      def initialize(s : UInt8*)
        super(s)
      end
    end

    macro objc_method_arg(value, type)
      {% if type == :NSUInteger %}
        {{value.id}}.to_nsuinteger
      {% elsif type == :BOOL %}
        {{value.id}} == true
      {% elsif type == :NSString %}
        {{value.id}}.is_a?(Crocoa::NSString) ? {{value.id}} : Crocoa::NSString.new({{value.id}})
      {% else %}
        {{value.id}}
      {% end %}
    end

    macro objc_init_method(method_name, crystal_method = nil)
      def self.{{(crystal_method || method_name).id}}
        self.new(nsclass.send_msg({{method_name}}))
      end
    end

    macro objc_method_helper(receiver, method_name, args = nil, returnType = nil, crystal_method = nil)
      # TODO auto method tidy up.
      def {{(crystal_method || method_name).id}}(
        {% for i in 0 ... (args || [] of Symbol).length %}
        # ???? new lines breaks
        # ???? unable to extract type restriction on its own macro
          {{"arg#{i}".id}} {%if args[i] != :id && args[i] != :NSUInteger %}{% if args[i] == :BOOL %}: Bool{% end %}{% if args[i] == :NSString %}: String|Crocoa::NSString {% end %}{% end %}{% end %})

        res = Crocoa.send_msg({{receiver}}, {{method_name}}
          {% for i in 0 ... (args || [] of Symbol).length %}
            , objc_method_arg({{"arg#{i}".id}}, {{args[i]}})
          {% end %}
        )

        # TODO wrap result if the class is exported from crystal and exposed to obj-c
        # ???? Posible to get all NSObject+ of the system? maybe using objc_class macro
        {% if returnType == :NSUInteger %}
          res.address
        {% elsif returnType == :BOOL %}
          res.address != 0
        {% elsif returnType == :unichar %}
          res.address.chr
        {% elsif returnType == :void || returnType == nil %}
          self
        {% elsif returnType == :id %}
          klass = NSClass.new(LibObjC.objc_msgSend(res, "class".to_sel.to_objc))
          if klass.name == "__NSCFString"
            Crocoa::NSString.new(res)
          else
            # TODO wrap result. NSObject+ if id
            res
          end
        {% else %}
          # TODO should deal with subclasses using somethign like :id and NSObject+
          Crocoa::{{returnType.id}}.new(res)
        {% end %}
      end
    end

    macro objc_method(method_name, args = nil, returnType = nil, crystal_method = nil)
      objc_method_helper(self.to_objc, {{method_name}}, {{args}}, {{returnType}}, {{crystal_method}})
    end

    macro objc_static_method(method_name, args = nil, returnType = nil, crystal_method = nil)
      objc_method_helper(nsclass.obj, {{method_name}}, {{args}}, {{returnType}}, {{"self.#{crystal_method.id || method_name.id}"}})
    end

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

    macro inherited
      objc_class
    end

    def to_objc
      @obj.not_nil!
    end

    def ==(other : NSObject)
      @obj == other.to_objc
    end

    def send_msg(message, *args)
      Crocoa.send_msg(to_objc, message, *args)
    end

    # ??? howto remove this. empty tuples for args seems not to be supported
    def alloc_init
      @obj = Crocoa.send_msg(nsclass.send_msg("alloc"), "init")
    end

    def alloc_init(init_method, *args)
      @obj = Crocoa.send_msg(nsclass.send_msg("alloc"), init_method, *args)
    end

    def finalize
      release
    end

    objc_method "retain"
    objc_method "release"
  end
end
