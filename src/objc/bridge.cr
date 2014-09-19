
class Object
  # to_objc is called in order to get value required to be
  # passed to objc
  abstract def to_objc
end

struct Nil
  def to_objc
    self
  end
end


struct Float
  def to_objc
    to_cgfloat
  end

  def to_cgfloat
    to_f64
  end
end

struct Int
  def to_objc
    self
  end

  def to_nsuinteger
    self.to_u64
  end
end

alias NSEnum = UInt64
alias CGFloat = Float64

struct Bool
  def to_objc
    self ? 0xFF_u8 : 0x00_u8
  end
end

class Pointer(T)
  def to_objc
    self
  end
end

class String
  def to_nsstring
    NSString.new self
  end
end

class Tuple
  def map_to_objc
    {% if @length == 0 %}
      self
    {% else %}
      {
        {% for i in 0 ... @length %}
          self[{{i}}].to_objc,
        {% end %}
      }
    {% end %}
  end
end

module Crocoa
  def self.send_msg(objc_target, selector_name, *args)
    objc_target.not_nil!
    LibObjC.objc_msgSend(objc_target, selector_name.to_sel.to_objc, *args.map_to_objc)
  end
end


