require "../spec_helper"

describe "NSMenu" do
  it "can be created" do
    Crocoa::NSMenu.new "aTitle"
  end

  it "menu items can be added" do
    menu = Crocoa::NSMenu.new "aTitle"
    menu << Crocoa::NSMenuItem.new("aTitle1", nil, "q")
    menu << Crocoa::NSMenuItem.new("aTitle2", nil, "q")
  end
end
