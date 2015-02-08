require "./nsobject_helper"

module Crocoa
  # represent instances that are defined in obj-c
  abstract class NSObject
    macro objc_class
      def initialize(s : UInt8*)
        super(s)
      end
    end

    macro import_class(objc_class_name = nil)
      def self.nsclass
        class_name = begin
          {% if objc_class_name %}
            {{objc_class_name}}
          {% else %}
            self.to_s["Crocoa::".length..-1]
          {% end %}
        end
        NSClass.new class_name
      end
    end

    macro export_class(objc_class_name = nil)
      $_{{@class_name.id}}_classPair = LibObjC.objc_allocateClassPair({{@superclass}}.nsclass.obj, {{@class_name}}, 0_u32)
      LibObjC.objc_registerClassPair($_{{@class_name.id}}_classPair)
      $x_{{@class_name.id}}_assoc_key = "crystal_obj"

      def self.nsclass
        NSClass.new $_{{@class_name.id}}_classPair
      end

      def initialize
        initialize(Crocoa.send_msg(nsclass.send_msg("alloc"), "init"))
        LibObjC.objc_setAssociatedObject(to_objc, $x_{{@class_name.id}}_assoc_key, Pointer(UInt8).new(self.object_id), LibObjC::AssociationPolicy::ASSIGN)
      end
    end

    macro export(method_name, selector = nil, types_encoding = nil)
      {{ "##{selector ||= method_name}".id }}
      {{ "##{types_encoding ||= "v@:"}".id }}
      $x_{{@class_name.id}}_{{method_name.id}}_imp = ->(obj : UInt8*, _cmd : LibObjC::SEL {%for t,i in types_encoding[3..-1].chars%}{{", a#{i} : UInt8*".id}}{%end%}) {
        ptr = LibObjC.objc_getAssociatedObject(obj, $x_{{@class_name.id}}_assoc_key)
        if ptr.nil?
          # if there is no associated object, it was created by [[alloc] init] and
          # there is no crystal object that corresponds to obj
          crystal_obj = {{@class_name.id}}.new(obj)
          LibObjC.objc_setAssociatedObject(obj, $x_{{@class_name.id}}_assoc_key, Pointer(UInt8).new(crystal_obj.object_id), LibObjC::AssociationPolicy::ASSIGN)
        else
          crystal_obj = ptr as {{@class_name.id}}
        end
        # TODO getAssociatedObject for params
        crystal_obj.{{method_name.id}}({%for t,i in types_encoding[3..-1].chars%}{%if i > 0%}{{",".id}}{%end%}{{"a#{i}".id}}{%end%})
      }
      LibObjC.class_addMethod($_{{@class_name.id}}_classPair, {{selector.stringify}}.to_sel.to_objc, $x_{{@class_name.id}}_{{method_name.id}}_imp.pointer as LibObjC::IMP, {{types_encoding}})
    end

    macro objc(code)
      # {{ puts run "../support/export_method", @class_name, code }}
      {{ run "../support/export_method", @class_name, code }}
    end

    import_class

    def nsclass
      self.class.nsclass
    end

    def initialize(pointer : UInt8*)
      @obj = pointer
      retain
    end

    # TODO only in non abstract classes
    macro inherited
      objc_class
    end

    def to_objc
      @obj.not_nil!
    end

    def to_id
      AnyObject.new(to_objc)
    end

    def ==(other : NSObject)
      @obj == other.to_objc
    end

    def finalize
      release
    end

    objc_method "retain"
    objc_method "release"

    objc_method "performSelectorOnMainThread:withObject:waitUntilDone:", ["SEL", "id", "BOOL"], "void", "perform_selector_on_main_thread_with_object_wait_until_done"
  end
end
