require "./nscontrol_spec"

def new_button
  NSButton.new(NSRect.new(0, 0, 200, 200))
end

describe "NSButton" do
  describe_nscontrol new_button

  it "title can be get/set" do
    c = new_button
    c.title = "Lorem ipsum"
    c.title.to_s.should eq("Lorem ipsum")
  end
end
