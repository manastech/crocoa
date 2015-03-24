require "ecr/macros"
require "../crocoa"
require "./tree_parser"

include Crocoa

module Import
  def self.crystal_method_for(method_name)
    # TODO simplify upon https://github.com/manastech/crystal/issues/492
    m = method_name.underscore

    m = m.gsub(/([A-Z]+)$/) do |str, match|
      match[0].downcase
    end

    m = m.gsub(/([A-Z]+)([A-Z])([a-z])/) do |str, match|
      "#{match[1].downcase}_#{match[2].downcase}#{match[3]}"
    end

    m = m.gsub(/([A-Z\d])([A-Z\d][a-z])/) do |str, match|
      "#{match[1]}_#{match[2]}"
    end

    m.downcase
  end
end

class ClassView
  getter :nsclass
  def initialize(@nsclass, @docs)
  end
  ecr_file "#{__DIR__}/import_class.ecr"

  def crystal_method_for(method : NSMethod)
    Import.crystal_method_for(method.name)
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

  def strong_return_type_for(nsclass, instance_method, method : NSMethod)
    @docs.return_type(nsclass.name, instance_method, method.name)
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
  def initialize(header)
    app_kit_ast = Process.run("/bin/sh", input: "clang -cc1 -ast-dump -fblocks -x objective-c #{header}", output: true).output.not_nil!
    @t = TreeParser.new(StringIO.new(app_kit_ast))
  end

  def return_type(nsclass_name, instance_method, method_name)
    return_type = nil
    @t.root.find_methods_related nsclass_name, -> (node: Tree) {
      return unless node.kind == "ObjCMethodDecl"
      if node.raw.match(Regex.new("#{instance_method ? '-' : '+'} #{method_name}"))
        if md = node.raw.match(/'(.*)':'.*'$/)
          return_type = md[1]
        elsif md = node.raw.match(/'(.*)'$/)
          return_type = md[1]
        else
          puts "return value not found"
          puts node
        end
      end
    }

    if return_type && return_type.not_nil!.ends_with? " *"
      return_type = return_type.not_nil![0..-3]
    end

    # puts "srt: #{nsclass_name}, #{instance_method}, #{method_name} -> #{return_type}"

    return_type = nil if ["NSDictionary"].includes?(return_type)

    return_type
  end
end

