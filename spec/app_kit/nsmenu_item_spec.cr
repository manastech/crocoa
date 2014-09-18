require "../spec_helper"

describe "NSMenuItem" do
  it "can be created" do
    Crocoa::NSMenuItem.new "aTitle", "terminate:", "q"
    Crocoa::NSMenuItem.new "aTitle", nil, "q"
  end

  it "title can read" do
    item = Crocoa::NSMenuItem.new "aTitle", nil, "q"
    item.title.to_s.should eq("aTitle")
  end

  it "title can be set" do
    item = Crocoa::NSMenuItem.new "aTitle", nil, "q"
    item.title = "anotherTitle"
    item.title.to_s.should eq("anotherTitle")
  end

  it "title can be set from NSString" do
    item = Crocoa::NSMenuItem.new "aTitle", nil, "q"
    item.title = Crocoa::NSString.new("anotherTitle")
    item.title.to_s.should eq("anotherTitle")
  end

  it "supports submenu" do
    item = Crocoa::NSMenuItem.new "aTitle", nil, "q"
    item.has_submenu?.should be_false

    menu = Crocoa::NSMenu.new "aSubmenu"
    item.submenu = menu
    item.submenu.should eq(menu)
  end
end
