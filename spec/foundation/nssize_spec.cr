require "../spec_helper"

describe "NSSize" do
  it "it can be created" do
    p = Crocoa::NSSize.new(42, 24)
    p.width.should eq(42)
    p.height.should eq(24)
  end
end
