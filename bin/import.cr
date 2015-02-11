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
end

def generate_class(class_name)
  puts ClassView.new(NSClass.new(class_name)).to_s
end

# generate_class "NSArray"
generate_class "NSString"



