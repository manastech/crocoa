def new_view
  NSView.new(NSRect.new(0, 0, 200, 200))
end

describe "NSView" do
  it "can be created" do
    new_view
  end

  it "sub view can be added" do
    new_view << new_view
  end
end
