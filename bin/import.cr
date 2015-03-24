require "../src/tools/import"

def generate_class(class_name, docs, path = nil)
  content = ClassView.new(NSClass.new(class_name), docs).to_s
  if path.nil?
    puts content
  else
    puts "#{class_name} -> #{__DIR__}/#{path}"
    File.write("#{__DIR__}/#{path}", content)
  end
end

header = "/System/Library/Frameworks/AppKit.framework/Headers/AppKit.h"

# generate_class "NSArray"
# generate_class "NSObject", Docs.new(), "../src/foundation/generated/nsobject.cr"
generate_class "NSString", Docs.new(header), "../src/foundation/generated/nsstring.cr"
# generate_class "NSMutableString", "../src/foundation/generated/nsmutablestring.cr"
# generate_class "__NSCFString", "../src/foundation/generated/__nscfstring.cr"
