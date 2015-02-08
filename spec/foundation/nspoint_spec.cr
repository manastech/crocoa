describe "NSPoint" do
  it "it can be created" do
    p = NSPoint.new(42, 24)
    p.x.should eq(42)
    p.y.should eq(24)
  end
end
