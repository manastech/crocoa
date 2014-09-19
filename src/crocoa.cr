require "./objc/*"
require "./foundation/*"
require "./core_foundation/*"
require "./app_kit/*"

include Crocoa

class String
  def to_nsstring
    NSString.new self
  end
end

struct Float
  def to_nsinteger
    self.to_i64.to_nsinteger
  end
end

struct Int
  def to_cgfloat
    self.to_f64.to_cgfloat
  end

  def to_nsinteger
    self.to_i64
  end

  def to_nsenum
    self.to_u64
  end

  def to_nsbool
    (self != 0).to_nsbool
  end
end

struct Bool
  def to_nsbool
    self ? 0xFF_u8 : 0x00_u8
  end
end
