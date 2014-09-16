module Crocoa
  class NSApplication < NSObject
    objc_init_method "sharedApplication", "shared_application"

    objc_method "run"
    objc_method "setActivationPolicy:", [:NSApplicationActivationPolicy], :BOOL, "activation_policy="
    objc_method "activateIgnoringOtherApps:", [:BOOL], :void, "activate_ignoring_other_apps="

    # def mainMenu=(menu : NSMenu)
    #   msgSend "setMainMenu:", menu
    # end
  end

  NSApp = NSApplication.shared_application
end
