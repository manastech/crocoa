describe "NSMutableArray" do
  it "count" do
    NSMutableArray.new.count.should eq(0)
    NSMutableArray.new.tap do |a|
      a << NSString.new("foo")
      a.count.should eq(1)
    end
  end

  it "index" do
    NSMutableArray.new.tap do |a|
      a << NSString.new("foo")
      a[0].is_a?(NSString).should eq(true)
      a[0].to_s.should eq("foo")
    end
  end
end
