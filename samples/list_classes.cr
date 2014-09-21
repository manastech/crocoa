require "../src/crocoa"
include Crocoa

NSClass.all do |nsclass|
  next unless nsclass.name.starts_with? "NS"
  next if nsclass.name == "NSObject"
  next if nsclass.superclass.nil?  # NSObject, NSLeafProxy

  puts "class #{nsclass} < #{nsclass.superclass}"
  puts "end"
end
