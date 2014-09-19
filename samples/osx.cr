require "../src/crocoa"
include Crocoa

# based on http://www.cocoawithlove.com/2010/09/minimalist-cocoa-programming.html

NSAutoreleasePool.new

NSApp.activation_policy = LibAppKit::NSApplicationActivationPolicy::Regular

menubar = NSMenu.new "main"
appMenuItem = NSMenuItem.new "Lorem", nil, "a"
menubar << appMenuItem
NSApp.main_menu = menubar

appMenu = NSMenu.new "app"
appName = NSProcessInfo.process_info.process_name

quitMenuItem = NSMenuItem.new "Quit #{appName}", "terminate:", "q"
appMenu << quitMenuItem
appMenuItem.submenu = appMenu

window = NSWindow.new(NSRect.new(0, 0, 200, 200), LibAppKit::NSWindowMask::Titled, LibAppKit::NSBackingStoreType::Buffered, false)
window.cascade_top_left_from_point NSPoint.new(20, 20)
window.title = appName
window.make_key_and_order_front nil


b = NSButton.new NSRect.new(50, 50, 100, 20)
b.title = "Copy"
$t1 = NSTextField.new NSRect.new(0, 170, 200, 20)
$t2 = NSTextField.new NSRect.new(0, 150, 200, 20)

# b.action = "terminate:"

objc_class :Foo do
  def bar
    $t2.value = $t1.value
    puts "Hi there"
  end

  objc_export :bar
end

b.target = Foo.new
b.action = "bar"

window.content_view << b
window.content_view << $t1
window.content_view << $t2

NSApp.activate_ignoring_other_apps = true
NSApp.run
