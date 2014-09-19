require "../spec_helper"

describe "NSRect" do
  it "it can be created" do
    p = NSRect.new(10, 20, 100, 200)
    p.x.should eq(10)
    p.y.should eq(20)
    p.origin.x.should eq(10)
    p.origin.y.should eq(20)
    p.width.should eq(100)
    p.height.should eq(200)
    p.size.width.should eq(100)
    p.size.height.should eq(200)
  end
end
