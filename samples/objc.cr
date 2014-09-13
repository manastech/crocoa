require "../src/crocoa"

klass = LibObjC.getClass("NSObject")
puts String.new(LibObjC.class_getName(klass))
