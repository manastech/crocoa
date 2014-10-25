@[Link(framework: "Foundation")]
@[Link(framework: "CoreFoundation")]
lib LibCF
  type CFString = Void*

  fun str = __CFStringMakeConstantString(UInt8*) : CFString

  struct Point
    x : CGFloat
    y : CGFloat
  end

  struct Size
    width : CGFloat
    height : CGFloat
  end

  struct Rect
    origin : Point
    size : Size
  end

  fun nslog = NSLog(UInt8*, ...)

  fun force : Void
end
