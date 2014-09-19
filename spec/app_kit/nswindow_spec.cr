require "../spec_helper"

describe "NSApplication" do
  def new_window
    NSWindow.new(NSRect.new(0, 0, 200, 200), LibAppKit::NSWindowMask::Titled, LibAppKit::NSBackingStoreType::Buffered, false)
  end

  it "can be created" do
    new_window
  end

  it "cascade_top_left_from_point can be set" do
    new_window.cascade_top_left_from_point NSPoint.new(30, 30)
  end

  it "can get/set title" do
    w = new_window
    w.title = "Lorem ipsum"
    w.title.to_s.should eq("Lorem ipsum")
  end

  it "make_key_and_order_front be called" do
    w = new_window
    w.cascade_top_left_from_point NSPoint.new(20, 20)
    w.title = "Lorem"
    w.make_key_and_order_front nil
  end

end
