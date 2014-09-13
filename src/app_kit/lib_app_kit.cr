lib LibAppKit("`echo \"-framework AppKit\"`")
  fun ns_run_alert_panel = NSRunAlertPanel(LibCF::CFString, LibCF::CFString,
                               LibCF::CFString, LibCF::CFString, LibCF::CFString, ...);

  fun ns_application_main = NSApplicationMain(UInt32, UInt8**) : UInt32
end
