@[Link(framework: "AppKit")]
lib LibAppKit
  enum NSApplicationActivationPolicy < NSEnum
     Regular,
     Accessory,
     Prohibited
  end

  fun ns_run_alert_panel = NSRunAlertPanel(LibCF::CFString, LibCF::CFString,
                               LibCF::CFString, LibCF::CFString, LibCF::CFString, ...);

  fun ns_application_main = NSApplicationMain(UInt32, UInt8**) : UInt32
end
