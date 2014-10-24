require "../src/crocoa"
include Crocoa

# force load libs
Crocoa.nslog "init.."

klass = LibObjC.objc_getClass("NSObject")
sel = "init"

c0 = klass
c = c0 as Pointer(UInt8)

orig = LibObjC.class_getInstanceMethod(c0, sel.to_sel.to_objc);
$orig = LibObjC.method_getImplementationAlloc(orig)
puts $orig
puts String.new(LibObjC.method_getTypeEncoding(orig))

my_init = -> (obj : UInt8*, _cmd : LibObjC::SEL) {
  s = $orig.call(obj, _cmd)
  puts "init!!"
  s
}

# puts LibObjC.class_replaceMethod(c, sel.to_sel.to_objc, my_init.pointer as LibObjC::IMP, LibObjC.method_getTypeEncoding(orig))
puts LibObjC.method_setImplementation(orig, my_init.pointer as LibObjC::IMP)

puts "a"
puts NSMutableArray.new
puts NSString.new("string1").to_objc
puts NSString.new("string2").to_objc
puts Crocoa.send_msg(NSMutableArray.nsclass.send_msg("alloc"), "init")
puts "b"
