require "./lib_objc.cr"

module Crocoa
  class Selector
    def initialize(name : String)
      @sel = LibObjC.sel_registerName(name)
    end

    def initialize(sel : LibObjC::SEL)
      @sel = sel
    end

    def name
      String.new(LibObjC.sel_getName(@sel))
    end

    def to_objc
      @sel
    end
  end
end

class String
  def to_sel
    Crocoa::Selector.new(self)
  end
end
