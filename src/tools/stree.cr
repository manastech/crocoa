require "./tree_parser"

header = "/System/Library/Frameworks/AppKit.framework/Headers/AppKit.h"
app_kit_ast = Process.run("/bin/sh", input: "clang -cc1 -ast-dump -fblocks -x objective-c #{header}", output: true).output.not_nil!

t = TreeParser.new(StringIO.new(app_kit_ast))

framework_prefix = "/System/Library/Frameworks/Foundation.framework/"

# t.root.childs.each do |node|
#   next unless ["ObjCInterfaceDecl", "EnumDecl"].includes?(node.kind)
#   local_decl = node.raw.match(/<[^<\/>]+>/) || node.raw.match(Regex.new("<#{framework_prefix}[^>]+>"))

#   # next if node.raw.match /<\// # skip other frame
#   next unless node.raw.match /NSString/

#   puts "#{local_decl ? '*' : '#'} #{node.raw}"

#   node.childs.each do |node|
#     puts "  #{node.raw}"
#     node.childs.each do |node|
#       puts "    #{node.raw}"
#     end
#   end
# end


# t.root.find_node(/NSStringExtensionMethods/, -> (node : Tree) {
#   StringIO.new.tap do |buffer|
#     node.parent.not_nil!.parent.not_nil!.print_trace_and_children(2, buffer)
#     puts buffer.to_s
#   end
#   puts "--"
# })

puts "ObjCInterface 0x102d1d280 'NSMutableString'".match Regex.new("^(ObjCInterface|ObjCInterfaceDecl).*#{"NSMutableString"}")

# t.root.find_class_related "NSString", -> (node: Tree) {
#   StringIO.new.tap do |buffer|
#     node.print_trace_and_children(2, buffer)
#     puts buffer.to_s
#   end
#   puts "--"
# }

t.root.find_methods_related "NSString", -> (node: Tree) {
  # return if node.kind == "ObjCMethodDecl"
  StringIO.new.tap do |buffer|
    node.print_trace_and_children(2, buffer)
    puts buffer.to_s
  end
  puts "--"
}


# def f(node, parents)
#   if node.raw.match(/ObjCMethodDecl/) && node.raw.match(/uppercaseString/)
#     puts parents.map &.raw
#     puts node.raw
#     return
#   end
#   parents.push node
#   node.childs.each do |c|
#     f(c, parents)
#   end
#   parents.pop
# end
# f(t.root, [] of Tree)
