module Crocoa
  class NSMethod
    def initialize(@method : LibObjC::Method)
    end

    def type_encoding
      String.new(LibObjC.method_getTypeEncoding(@method))
    end

    def args_count
      # 0 and 1 args are self and SEL
      LibObjC.method_getNumberOfArguments(@method) - 2
    end

    def return_type_encoding
      @return_type ||= String.new(LibObjC.method_copyReturnType(@method))
    end

    def return_type
      case return_type_encoding
      when "Q"; "unsigned long long"
      when "q"; "long long"
      when "@"; "id"
      when "i"; "int"
      when "f"; "float"
      when "d"; "double"
      when "c"; "char"
      when "#"; "Class"
      when "*", "r*"; "char *" # TODO deal with modifiers like 'r' for const
      else
        raise "not implemented: return_type_as_nsclass_name for #{return_type}"
      end
    end

    def return_type_supported?
      ["Q","q","@","i","f","d","c","#","*","r*"].includes? return_type_encoding
    end

    def sel
      Selector.new(LibObjC.method_getName(@method))
    end

    def name
      sel.to_s
    end
  end
end
