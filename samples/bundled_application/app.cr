require "../../src/crocoa"
include Crocoa

# require "../list_classes"

class MyAppDelegate < NSObject
  export_class

  LibObjC.class_addProtocol(MyAppDelegate.nsclass.obj, LibObjC.objc_getProtocol("NSApplicationDelegate"))

  def did_finish_launching(notification)
    Crocoa.nslog "didFinishLaunching"
  end
  export did_finish_launching, "applicationDidFinishLaunching:", "v@:@"

end

# $x_MyAppDelegate_objc_class_initWithCoder_imp = ->(obj : UInt8*, _cmd : LibObjC::SEL, _coder : UInt8*) {
#   `touch /Users/bcardiff/Work/Manas/crystal/crocoa/samples/bundled_application/xx-init-coder.txt`
#   obj
# }
# LibObjC.class_addMethod($x_MyAppDelegate_objc_class.obj, "initWithCoder:".to_sel.to_objc, $x_MyAppDelegate_objc_class_initWithCoder_imp.pointer as LibObjC::IMP, "@@:@")

# $x_MyAppDelegate_objc_class_init_imp = ->(obj : UInt8*, _cmd : LibObjC::SEL) {
#   `touch /Users/bcardiff/Work/Manas/crystal/crocoa/samples/bundled_application/xx-init.txt`
#   obj
# }
# LibObjC.class_addMethod($x_MyAppDelegate_objc_class.obj, "init".to_sel.to_objc, $x_MyAppDelegate_objc_class_init_imp.pointer as LibObjC::IMP, "@@:")


# a = LibObjC.objc_msgSend($x_MyAppDelegate_objc_class.obj, "alloc".to_sel.to_objc)
# LibObjC.objc_msgSend(a, "init".to_sel.to_objc)
# `touch /Users/bcardiff/Work/Manas/crystal/crocoa/samples/bundled_application/xx-foo.txt`

# list_class MyAppDelegate.nsclass

LibAppKit.ns_application_main 0u32, nil

# class Foo < NSObject
#   export_class
#
#   def mySelector()
#     $t2.value = $t1.value
#     puts "Hi there"
#   end
#
#   export "mySelector:"
# end

