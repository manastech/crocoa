lib LibCF("`echo \"-framework CoreFoundation\"`")
  type CFString : Void*

  fun str = __CFStringMakeConstantString(UInt8*) : CFString

  struct Point
    x : Float64
    y : Float64
  end

  struct Size
    width : Float64
    height : Float64
  end

  struct Rect
    origin : Point
    size : Size
  end
end
