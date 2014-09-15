lib LibObjC("objc")
  # type Id : UInt8* #UInt64
  type SEL : Void*
  # type Class : UInt8*
  # type size_t : UInt32
  type IMP : Pointer(UInt8), LibObjC::SEL ->
  # type IMP : Void*

  fun objc_getClass(UInt8*) : UInt8*
  fun class_getName(UInt8*) : UInt8*
  fun objc_msgSend(UInt8*, SEL, ...) : UInt8*

  fun sel_registerName(UInt8*) : SEL
  fun sel_getName(SEL) : UInt8*

  fun objc_allocateClassPair(UInt8*, UInt8*, UInt32) : UInt8*

  fun class_addMethod(UInt8*, SEL, IMP, UInt8*) : UInt8

end
