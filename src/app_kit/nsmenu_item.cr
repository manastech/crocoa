module Crocoa
  class NSMenuItem < NSObject
    def initialize(title : String, action : String?, keyEquivalent : String)
      alloc_init "initWithTitle:action:keyEquivalent:",
        NSString.new(title), action.to_sel, NSString.new(keyEquivalent)
    end

    objc_method "title", nil, :NSString
    objc_method "setTitle:", [:NSString], :void, "title="

    # objc_method "- (void)setTitle:(NSString *)aString"

    # def submenu=(menu : NSMenu)
    #   msgSend "setSubmenu:", menu
    # end
  end
end
