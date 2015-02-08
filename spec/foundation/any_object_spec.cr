require "../spec_helper"

describe "AnyObject" do
  it "respond to nsclass of instance" do
    id = NSMutableArray.new.to_id
    id.nsclass.name.should eq("__NSArrayM")
  end

  it "respond to missing method that returns NSUInteger" do
    id = NSMutableArray.new.to_id
    id.count.to_i.should eq(0)
  end

  it "respond to missing method that returns NSString" do
    button = NSButton.new(NSRect.new(0, 0, 200, 200))
    button.title = "Lorem ipsum"
    button.to_id.title.as(NSString).to_s.should eq("Lorem ipsum")
  end
end
