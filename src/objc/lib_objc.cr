@[Link("objc")]
lib LibObjC
  # type Id : UInt8* #UInt64
  type SEL = Void*
  # type Class : UInt8*
  # type size_t : UInt32
  alias IMP = Void* # Pointer(UInt8), LibObjC::SEL, ... -> ?
  alias IMPAlloc = Pointer(UInt8), LibObjC::SEL -> UInt8*

  type Protocol = Void*

  struct ObjcClass;end
  struct ObjcClass
    isa : ObjcClass*
    super_class : ObjcClass*
  end
  alias Class = ObjcClass*
  type Method = Void*

  struct ObjcMethodDescription
    name : SEL
    types : UInt8*
  end

  fun objc_getClass(UInt8*) : Class
  fun class_getName(Class) : UInt8*

  fun objc_getClassList(Class*, UInt64) : UInt64
  fun class_getSuperclass(Class) : Class

  fun objc_msgSend(UInt8*, SEL, ...) : UInt8*

  fun sel_registerName(UInt8*) : SEL
  fun sel_getName(SEL) : UInt8*

  fun objc_allocateClassPair(Class, UInt8*, UInt32) : UInt8*
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
  fun class_replaceMethod(UInt8*, SEL, IMP, UInt8*) : IMP

  fun class_copyMethodList(Class, UInt32*) : Method*
  fun method_getName(Method) : SEL
  fun method_copyArgumentType(Method, UInt64) : UInt8*
  fun method_copyReturnType(Method) : UInt8*
  fun method_getNumberOfArguments(Method) : UInt64
  fun method_getTypeEncoding(Method) : UInt8*
  fun method_getDescription(Method) : ObjcMethodDescription*
  fun method_getImplementation(Method) : IMPAlloc
  fun class_getMethodImplementation(Class, SEL) : IMPAlloc
  fun class_getInstanceMethod(Class, SEL) : Method

  fun objc_getProtocol(UInt8*) : Protocol
  fun class_addProtocol(Class, Protocol) : UInt8
end
