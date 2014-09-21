require "../src/crocoa"
include Crocoa

NSClass.all do |nsclass|
  next unless nsclass.name.starts_with? "NS"
  next if nsclass.name == "NSObject"
  next if nsclass.superclass.nil?  # NSObject, NSLeafProxy

  puts "class #{nsclass} < #{nsclass.superclass}"
    method_count = 0u32
    methods = LibObjC.class_copyMethodList(nsclass.obj, out method_count)

    unless method_count == 0 || methods.nil?
      methods.as_enumerable(method_count).each do |method|
        s = ""
        LibObjC.method_getNumberOfArguments(method).times do |i|
          next if i == 0 || i == 1
          s += String.new(LibObjC.method_copyArgumentType(method, i))
        end

        puts "\t#{Selector.new(LibObjC.method_getName(method))}, (#{
          LibObjC.method_getNumberOfArguments(method)}), #{s}, #{
          String.new(LibObjC.method_copyReturnType(method))} ... #{
          String.new(LibObjC.method_getTypeEncoding(method))}"

        md = LibObjC.method_getDescription(method)
        puts Selector.new(md.value.name)
        puts String.new(md.value.types)
      end
    end
  puts "end"
end
