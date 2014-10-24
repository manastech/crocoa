require "../src/crocoa"
include Crocoa

Crocoa.nslog "(nslog) text"

# klass = NSMutableArray.nsclass
klass = NSClass.new "NSArray"
alloced = klass.send_msg "alloc"
placeholder = NSClass.new(LibObjC.object_getClass(alloced))

initialized = Crocoa.send_msg(alloced, "init")
initialized_class = NSClass.new(LibObjC.object_getClass(initialized))

puts "#{klass} => #{placeholder} => #{initialized_class}"
