macro objc_class(class_name)
  $_{{class_name.id}}_classPair = LibObjC.objc_allocateClassPair(NSClass.new("NSObject").obj, {{class_name.id.stringify}}, 0_u32)
  LibObjC.objc_registerClassPair($_{{class_name.id}}_classPair)

  $x_{{class_name.id}}_objc_class = NSClass.new($_{{class_name.id}}_classPair)
  # TODO
  # register instance variable for crystal self using class_addIvar
  #     use it in methods instead of creating new objects each time
  # call objc_registerClassPair then mapped_class could be fixed
  $x_{{class_name.id}}_assoc_key = "crystal_obj"

  class {{class_name.id}} < NSObject
    # objc_method "init", nil, :id, "initialize"

    def self.nsclass
      $x_{{class_name.id}}_objc_class
    end

    def initialize
      initialize(Crocoa.send_msg(Crocoa.send_msg(nsclass.obj, "alloc"), "init"))
      LibObjC.objc_setAssociatedObject(to_objc, $x_{{class_name.id}}_assoc_key, Pointer(UInt8).new(self.object_id), LibObjC::AssociationPolicy::ASSIGN)
    end

    {{yield}}
  end
end

macro objc_export(method_name)
  $x_{{@class_name.id}}_{{method_name.id}}_imp = ->(obj : UInt8*, _cmd : LibObjC::SEL) {
    ptr = LibObjC.objc_getAssociatedObject(obj, $x_{{@class_name.id}}_assoc_key)
    if ptr.nil?
      # if there is no associated object, it was created by [[alloc] init] and
      # there is no crystal object that corresponds to obj
      crystal_obj = {{@class_name.id}}.new(obj)
      LibObjC.objc_setAssociatedObject(obj, $x_{{@class_name.id}}_assoc_key, Pointer(UInt8).new(crystal_obj.object_id), LibObjC::AssociationPolicy::ASSIGN)
    else
      crystal_obj = ptr as {{@class_name.id}}
    end
    crystal_obj.{{method_name.id}}
  }
  LibObjC.class_addMethod($x_{{@class_name.id}}_objc_class.obj, {{method_name.id.stringify}}.to_sel.to_objc, $x_{{@class_name.id}}_{{method_name.id}}_imp.pointer as LibObjC::IMP, "v@:")
end
