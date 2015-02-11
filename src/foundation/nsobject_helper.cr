macro objc_method_arg(value, type)
  {% if type == "NSUInteger" %}
    {{value.id}}.to_nsuinteger
  {% elsif type == "BOOL" %}
    {{value.id}}
  {% elsif type == "SEL" %}
    {{value.id}}.to_sel
  {% elsif type == "NSString" %}
    {{value.id}}.to_nsstring
  {% elsif type == "const_char_ptr" %}
    {{value.id}}.cstr
  {% else %}
    {{value.id}}
  {% end %}
end

# TODO remove and add options to objc_static_method
macro objc_init_method(method_name, crystal_method = nil)
  {{ "##{crystal_method ||= method_name}".id }}
  def self.{{crystal_method.id}}
    self.new(nsclass.send_msg({{method_name}}))
  end
end

macro objc_method_helper(receiver, method_name, args = nil, returnType = nil, crystal_method = nil)
  # TODO auto method tidy up.
  # ???? new lines breaks
  # ???? unable to extract type restriction on its own macro
  {{ "##{crystal_method ||= method_name}".id }}
  {{ "##{args ||= [] of Symbol}".id }}
  def {{crystal_method.id}}({% for i in 0 ... args.length %}{% if i > 0 %} , {% end %} {{"arg#{i}".id}} {%if args[i] != :id && args[i] != :NSUInteger %}{% if args[i] == :BOOL %}: Bool{% end %}{% if args[i] == :NSString %}: String|NSString {% end %}{% if args[i] == :SEL %}: Selector|String? {% end %}{% if args[i] == :const_char_ptr %}: String {% end %}{% end %}{% end %})

    res = Crocoa.send_msg({{receiver}}, {{method_name}}
      {% for i in 0 ... args.length %}
        , objc_method_arg({{"arg#{i}".id}}, {{args[i]}})
      {% end %}
    )

    # TODO wrap result if the class is exported from crystal and exposed to obj-c
    # ???? Posible to get all NSObject+ of the system? maybe using objc_class macro
    {% if crystal_method == "initialize" %}
      @obj = res
    {% elsif returnType == "NSUInteger" %}
      res.address
    {% elsif returnType == "BOOL" %}
      res.address != 0
    {% elsif returnType == "unichar" %}
      res.address.chr
    {% elsif returnType == "void" || returnType == nil %}
      self
    {% elsif returnType == "id" %}
      klass = NSClass.new(LibObjC.objc_msgSend(res, "class".to_sel.to_objc) as LibObjC::Class)
      if klass.name == "__NSCFString"
        NSString.new(res)
      elsif klass.name == "NSButton"
        NSButton.new(res)
      elsif klass.name == "NSTextField"
        NSTextField.new(res)
      else
        # TODO wrap result. NSObject+ if id
        res
      end
    {% else %}
      # TODO should deal with subclasses using something like id and NSObject+
      {{returnType.id}}.new(res)
    {% end %}
  end
end

macro objc_method_helper_body(receiver, method_name, args = nil, returnType = nil, crystal_method = nil)
  # TODO auto method tidy up.
  # ???? new lines breaks
  # ???? unable to extract type restriction on its own macro
  {{ "##{crystal_method ||= method_name}".id }}
  {{ "##{args ||= [] of Symbol}".id }}

  res = Crocoa.send_msg({{receiver}}, {{method_name}}
    {% for i in 0 ... args.length %}
      , objc_method_arg({{"arg#{i}".id}}, {{args[i]}})
    {% end %}
  )

  # TODO wrap result if the class is exported from crystal and exposed to obj-c
  # ???? Posible to get all NSObject+ of the system? maybe using objc_class macro
  {% if crystal_method == "initialize" %}
    @obj = res
  {% elsif returnType == "NSUInteger" %}
    res.address
  {% elsif returnType == "BOOL" %}
    res.address != 0
  {% elsif returnType == "unichar" %}
    res.address.chr
  {% elsif returnType == "void" || returnType == nil %}
    self
  {% elsif returnType == "id" %}
    klass = NSClass.new(LibObjC.objc_msgSend(res, "class".to_sel.to_objc) as LibObjC::Class)
    if klass.name == "__NSCFString"
      NSString.new(res)
    elsif klass.name == "NSButton"
      NSButton.new(res)
    elsif klass.name == "NSTextField"
      NSTextField.new(res)
    else
      # TODO wrap result. NSObject+ if id
      res
    end
  {% else %}
    # runtime return type check
    if {{returnType}} == "id"
      AnyObject.new(res)
    elsif {{returnType}} == "unsigned long long"
      res.address
    else
      raise "not implemented as return type #{returnType}"
    end
  {% end %}
end

macro objc_method(method_name, args = nil, returnType = nil, crystal_method = nil)
  {% if crystal_method == "initialize" %}
    objc_method_helper(nsclass.send_msg("alloc"), {{method_name}}, {{args}}, {{returnType}}, {{crystal_method}})
  {% else %}
    objc_method_helper(self.to_objc, {{method_name}}, {{args}}, {{returnType}}, {{crystal_method}})
  {% end %}
end

macro objc_method_body(method_name, args = nil, returnType = nil, crystal_method = nil)
  {% if crystal_method == "initialize" %}
    objc_method_helper_body(nsclass.send_msg("alloc"), {{method_name}}, {{args}}, {{returnType}}, {{crystal_method}})
  {% else %}
    objc_method_helper_body(self.to_objc, {{method_name}}, {{args}}, {{returnType}}, {{crystal_method}})
  {% end %}
end

macro objc_static_method(method_name, args = nil, returnType = nil, crystal_method = nil)
  {{ "##{crystal_method ||= method_name}".id }}
  objc_method_helper(nsclass.obj as Pointer(UInt8), {{method_name}}, {{args}}, {{returnType}}, {{"self.#{crystal_method.id}"}})
end
