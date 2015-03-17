require "ecr/macros"
require "../src/crocoa"

include Crocoa

class ClassView
  getter :nsclass
  def initialize(@nsclass)
  end
  ecr_file "#{__DIR__}/import_class.ecr"

  def crystal_method_for(method : NSMethod)
    method.name.underscore.gsub(/([A-Z]+)([A-Z])([a-z])/) do |str, match|
      "#{match[1].downcase}_#{match[2].downcase}#{match[3]}"
    end
  end

  def return_type_for(method : NSMethod)
    method.return_type
  end

  def send_message_for(method : NSMethod)
    if method.return_type == "double"
      :send_msg_fpret
    else
      :send_msg
    end
  end
end

def generate_class(class_name, path = nil)
  content = ClassView.new(NSClass.new(class_name)).to_s
  if path.nil?
    puts content
  else
    puts "#{class_name} -> #{__DIR__}/#{path}"
    File.write("#{__DIR__}/#{path}", content)
  end
end

# generate_class "NSArray"
generate_class "NSString", "../src/foundation/generated/nsstring.cr"



