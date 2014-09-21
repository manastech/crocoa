@[Link("objc")]
lib LibObjC
  # type Id : UInt8* #UInt64
  type SEL = Void*
  # type Class : UInt8*
  # type size_t : UInt32
  type IMP = Pointer(UInt8), LibObjC::SEL ->
  type IMP2 = Pointer(UInt8), LibObjC::SEL, Pointer(UInt8) ->
  type IMP3 = Pointer(UInt8), LibObjC::SEL -> Pointer(UInt8)
  type IMP4 = Pointer(UInt8), LibObjC::SEL, Pointer(UInt8) ->

  type Protocol = Void*

  fun objc_getClass(UInt8*) : UInt8*
  fun class_getName(UInt8*) : UInt8*
  fun objc_msgSend(UInt8*, SEL, ...) : UInt8*

  fun sel_registerName(UInt8*) : SEL
  fun sel_getName(SEL) : UInt8*

  fun objc_allocateClassPair(UInt8*, UInt8*, UInt32) : UInt8*
  fun objc_registerClassPair(UInt8*) : Void

  enum AssociationPolicy < Int32
    ASSIGN  = 0u64,
    RETAIN_NONATOMIC  = 1u64,
    COPY_NONATOMIC  = 3u64,
    RETAIN  = 01401u64,
    COPY  = 01403u64
  end
  fun objc_getAssociatedObject (UInt8*, UInt8*) : UInt8*;
  fun objc_setAssociatedObject (UInt8*, UInt8*, UInt8*, AssociationPolicy) : Void

  fun class_addMethod(UInt8*, SEL, IMP, UInt8*) : UInt8
  fun class_addMethod2 = class_addMethod(UInt8*, SEL, IMP2, UInt8*) : UInt8
  fun class_addMethod3 = class_addMethod(UInt8*, SEL, IMP3, UInt8*) : UInt8
  fun class_addMethod4 = class_addMethod(UInt8*, SEL, IMP4, UInt8*) : UInt8

  fun objc_getProtocol(UInt8*) : Protocol
  fun class_addProtocol(UInt8*, Protocol) : UInt8
end
