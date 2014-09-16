
class Object
  # to_objc is called in order to get value required to be
  # passed to objc
  abstract def to_objc
end

struct Nil
  def to_sel
    self
  end

  def to_objc
    self
  end
end


struct Float
  def to_objc
    self
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

class Tuple
  def map_to_objc
    {% if true %}
      {
        {% for i in 0 ... @length %}
          self[{{i}}].to_objc,
        {% end %}
      }
    {% end %}
  end
end

module Crocoa
  def self.send_msg(objc_target, selector_name)
    objc_target.not_nil!
    LibObjC.objc_msgSend(objc_target, selector_name.to_sel.to_objc)
  end

  def self.send_msg(objc_target, selector_name, arg1)
    objc_target.not_nil!
    LibObjC.objc_msgSend(objc_target, selector_name.to_sel.to_objc, arg1.to_objc)
  end
end


# def self.send_msg(objc_target, selector_name, *args)
#   LibObjC.objc_msgSend(objc_target, selector_name.to_sel.to_objc, *args.map_to_objc)
# end
