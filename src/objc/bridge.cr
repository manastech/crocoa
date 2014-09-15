
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
end

struct Bool
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
  def self.send_msg(objc_target, selector_name, *args)
    LibObjC.objc_msgSend(objc_target, selector_name.to_sel.to_objc, *args.map_to_objc)
  end
end
