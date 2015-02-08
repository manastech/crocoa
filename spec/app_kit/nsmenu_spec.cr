describe "NSMenu" do
  it "can be created" do
    NSMenu.new "aTitle"
  end

  it "menu items can be added" do
    menu = NSMenu.new "aTitle"
    menu << NSMenuItem.new("aTitle1", nil, "q")
    menu << NSMenuItem.new("aTitle2", nil, "q")
  end
end
