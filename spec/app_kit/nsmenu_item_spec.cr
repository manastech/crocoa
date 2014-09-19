require "../spec_helper"

describe "NSMenuItem" do
  it "can be created" do
    NSMenuItem.new "aTitle", "terminate:", "q"
    NSMenuItem.new "aTitle", nil, "q"
  end

  it "title can read" do
    item = NSMenuItem.new "aTitle", nil, "q"
    item.title.to_s.should eq("aTitle")
  end

  it "title can be set" do
    item = NSMenuItem.new "aTitle", nil, "q"
    item.title = "anotherTitle"
    item.title.to_s.should eq("anotherTitle")
  end

  it "title can be set from NSString" do
    item = NSMenuItem.new "aTitle", nil, "q"
    item.title = NSString.new("anotherTitle")
    item.title.to_s.should eq("anotherTitle")
  end

  it "supports submenu" do
    item = NSMenuItem.new "aTitle", nil, "q"
    item.has_submenu?.should be_false

    menu = NSMenu.new "aSubmenu"
    item.submenu = menu
    item.submenu.should eq(menu)
  end
end
