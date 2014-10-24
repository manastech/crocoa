require "../src/crocoa"
include Crocoa

klass = NSObject
sel = "init"

c0 = klass.nsclass.obj
c = c0 as Pointer(UInt8)

orig = LibObjC.class_getInstanceMethod(c0, sel.to_sel.to_objc);
typeEncoding = String.new(LibObjC.method_getTypeEncoding(orig))
puts typeEncoding

$initCrocoa = -> (obj : UInt8*, _cmd : LibObjC::SEL) {
  Crocoa.nslog "initCrocoa"
  puts "initCrocoa"
  x = Crocoa.send_msg(obj, "initCrocoa".to_sel)
  return x
}
LibObjC.class_addMethod(c, "initCrocoa".to_sel.to_objc, $initCrocoa.pointer as LibObjC::IMP, "@@:")

newMethod = LibObjC.class_getInstanceMethod(c0, "initCrocoa".to_sel.to_objc);

LibObjC.method_exchangeImplementations(orig, newMethod)

puts "a"
# Crocoa.send_msg(NSArray.nsclass.send_msg("alloc"), "init")
NSMenu.new "title"
a = NSMutableArray.new

Crocoa.send_msg(NSMutableArray.nsclass.send_msg("alloc"), "init")
Crocoa.send_msg(NSMutableArray.nsclass.send_msg("alloc"), "initCrocoa")
puts NSString.new "foo"
puts "b"
