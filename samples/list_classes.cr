require "../src/crocoa"
include Crocoa

def list_methods(nsclass, prefix)
  method_count = 0u32
  methods = LibObjC.class_copyMethodList(nsclass.obj, out method_count)

  unless method_count == 0 || methods.nil?
    methods.to_slice(method_count.to_i).each do |method|
      s = ""
      LibObjC.method_getNumberOfArguments(method).times do |i|
        next if i == 0 || i == 1
        s += String.new(LibObjC.method_copyArgumentType(method, i))
      end

      puts "\t#{prefix} #{Selector.new(LibObjC.method_getName(method))}, (#{
        LibObjC.method_getNumberOfArguments(method)}), #{s}, #{
        String.new(LibObjC.method_copyReturnType(method))} ... #{
        String.new(LibObjC.method_getTypeEncoding(method))}"

      # md = LibObjC.method_getDescription(method)
      # puts Selector.new(md.value.name)
      # puts String.new(md.value.types)
    end
  end
end

def list_class(nsclass)
  puts "class #{nsclass} < #{nsclass.superclass}"
  list_methods nsclass.metaclass, "+"
  list_methods nsclass, "-"
  puts "end"
end

def list_all_classes
  NSClass.all do |nsclass|
    # next unless nsclass.name.starts_with? "NS"
    # next if nsclass.name == "NSObject"
    # next if nsclass.superclass.nil?  # NSObject, NSLeafProxy
    list_class nsclass
  end
end

# list_all_classes
