module Crocoa
  class NSMenuItem < NSObject
    def initialize(title : String, action : String?, keyEquivalent : String)
      alloc_init "initWithTitle:action:keyEquivalent:",
        NSString.new(title), action.to_sel, NSString.new(keyEquivalent)
    end

    objc_method "title", nil, :NSString
    objc_method "setTitle:", [:NSString], :void, "title="

    objc_method "hasSubmenu", nil, :BOOL, "has_submenu?"
    objc_method "submenu", nil, :NSMenu, "submenu"
    objc_method "setSubmenu:", [:NSMenu], :void, "submenu="
  end
end
