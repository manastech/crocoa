
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
