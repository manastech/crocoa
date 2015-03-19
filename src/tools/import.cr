require "ecr/macros"
require "../crocoa"

include Crocoa

class ClassView
  getter :nsclass
  def initialize(@nsclass, @docs)
  end
  ecr_file "#{__DIR__}/import_class.ecr"

  def crystal_method_for(method : NSMethod)
    method.name.underscore.gsub(/([A-Z]+)([A-Z])([a-z])/) do |str, match|
      "#{match[1].downcase}_#{match[2].downcase}#{match[3]}"
    end
  end

  def source_location(nsclass)
    "./#{crystal_class_name(nsclass).downcase}"
  end

  def crystal_class_name(nsclass : NSClass)
    crystal_class_name(nsclass.name)
  end

  def crystal_class_name(nsclass_name : String)
    nsclass_name.gsub(/^_+/) { "" }
  end

  def return_type_for(method : NSMethod)
    method.return_type
  end

  def strong_return_type_for(method : NSMethod)
    @docs.return_type(method.name)
  end

  def send_message_for(method : NSMethod)
    if method.return_type == "double"
      :send_msg_fpret
    elsif method.return_type == "float"
      :send_msg_float32
    else
      :send_msg
    end
  end
end

class Docs
  def initialize(@d = {} of String => String)
  end

  def return_type(method_name)
    @d[method_name]?
  end
end

