require "../spec_helper"

describe "NSPoint" do
  it "it can be created" do
    p = Crocoa::NSPoint.new(42, 24)
    p.x.should eq(42)
    p.y.should eq(24)
  end
end
