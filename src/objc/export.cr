macro objc_class(class_name)
  class {{class_name.id}} < NSObject
    property :obj
  end

  $x_{{class_name.id}}_objc_class = NSClass.new(LibObjC.objc_allocateClassPair(NSClass.new("NSObject").obj, {{class_name.id.stringify}}, 0_u32))
  # TODO
  # register instance variable for crystal self using class_addIvar
  #     use it in methods instead of creating new objects each time
  # call objc_registerClassPair then mapped_class could be fixed

  class {{class_name.id}}

    def self.nsclass
      $x_{{class_name.id}}_objc_class
    end

    objc_method "init", nil, :id, "initialize"

    {{yield}}
  end
end

macro objc_export(method_name)
  $x_{{@class_name.id}}_{{method_name.id}}_imp = ->(obj : UInt8*, _cmd : LibObjC::SEL) {
    {{@class_name.id}}.new(obj).{{method_name.id}}
  }
  LibObjC.class_addMethod($x_{{@class_name.id}}_objc_class.obj, {{method_name.id.stringify}}.to_sel.to_objc, $x_{{@class_name.id}}_{{method_name.id}}_imp, "v@:")
end
