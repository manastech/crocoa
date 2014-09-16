describe "NSMutableArray" do
  it "count" do
    Crocoa::NSMutableArray.new.count.should eq(0)
    Crocoa::NSMutableArray.new.tap do |a|
      a << Crocoa::NSString.new("foo")
      a.count.should eq(1)
    end
  end

  it "index" do
    Crocoa::NSMutableArray.new.tap do |a|
      a << Crocoa::NSString.new("foo")
      a[0].is_a?(Crocoa::NSString).should eq(true)
      a[0].to_s.should eq("foo")
    end
  end
end
