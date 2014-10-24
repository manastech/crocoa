require "../src/crocoa"
include Crocoa

klass = NSObject
sel = "alloc"

3.times do
  a = NSMutableArray.nsclass.send_msg("alloc")
  puts a
  b = NSMutableArray.new(Crocoa.send_msg a, "init")
  puts b
  b << NSMutableArray.new
  puts

end

# puts klass.nsclass
# puts klass.nsclass.metaclass
# puts klass.nsclass.metaclass.metaclass

# metaklass = NSObject.nsclass.metaclass.obj
# klass_load = ->(obj : UInt8*, _cmd : LibObjC::SEL) {
#   puts "load"
# }
# LibObjC.class_addMethod(metaklass as Pointer(UInt8), "loada".to_sel.to_objc, klass_load.pointer as LibObjC::IMP, "@@:")

# klass = NSMutableArray
# sel = "addObject:"

# metaklass = LibObjC.objc_getClass(klass.nsclass.obj)
# puts String.new(LibObjC.class_getName(metaklass))

# klass_load = ->(obj : UInt8*, _cmd : LibObjC::SEL) {
#   puts "loaded"
# }
# LibObjC.class_addMethod(metaklass, "load".to_sel.to_objc, klass_load.pointer as LibObjC::IMP, "v@:")

# NSMutableArray.class.obj


Crocoa.send_msg klass.nsclass.obj as UInt8*, "load"

c0 = klass.nsclass.metaclass.obj
# c0 = LibObjC.object_getClass(klass.nsclass.obj as UInt8*)
c = c0 as Pointer(UInt8)

orig = LibObjC.class_getInstanceMethod(c0, sel.to_sel.to_objc);
$orig = LibObjC.class_getMethodImplementation(c0, sel.to_sel.to_objc)
# $orig = LibObjC.method_getImplementation(orig)
# puts $orig
# puts String.new(LibObjC.method_getTypeEncoding(orig))

my_alloc = -> (obj : UInt8*, _cmd : LibObjC::SEL) {
  s = $orig.call(obj, _cmd)
  puts "alloc!!#{s}"
  s
}

puts LibObjC.class_replaceMethod(c, sel.to_sel.to_objc, my_alloc.pointer as LibObjC::IMP, LibObjC.method_getTypeEncoding(orig))
puts "+" + String.new(LibObjC.method_getTypeEncoding(orig)) + "+"

puts "a"
z = NSMutableArray.new
puts z.to_objc
s = "sds".to_nsstring
puts s.to_objc
z << s
a = NSMutableArray.new
puts a.to_objc
a << NSMutableArray.new
puts "b"
puts a[0]
