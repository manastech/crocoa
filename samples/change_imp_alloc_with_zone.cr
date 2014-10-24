require "../src/crocoa"
include Crocoa

klass = NSObject
sel = "allocWithZone:"

c0 = klass.nsclass.obj
c = c0 as Pointer(UInt8)

orig = LibObjC.class_getClassMethod(c0, sel.to_sel.to_objc);
$orig = LibObjC.method_getImplementation(orig)
# puts $orig
puts String.new(LibObjC.method_getTypeEncoding(orig))

puts "(puts) test"
Crocoa.nslog "(nslog) text"


my_init = -> (obj : UInt8*, _cmd : LibObjC::SEL, zone : UInt8*) {
  puts "called"
  s = $orig.call(obj, _cmd, zone)
  puts "allocWithZone!!"
  Crocoa.nslog "allocWithZone!!"
  s
}

# @24@0:8^{_NSZone=}16

# puts LibObjC.class_replaceMethod(c, sel.to_sel.to_objc, my_init.pointer as LibObjC::IMP, LibObjC.method_getTypeEncoding(orig))
puts LibObjC.method_setImplementation(orig, my_init.pointer as LibObjC::IMP)


puts "a"
a = NSMutableArray.new
Crocoa.send_msg(NSMutableArray.nsclass.send_msg("alloc"), "init")
puts "b"
