require "spec"
require "../src/crocoa"

describe "NSObject" do
  it "objc_class" do
    "a".to_nsstring.objc_class.name.should eq("__NSCFConstantString")
  end
end

describe "NSMutableArray" do
  it "count" do
    NSMutableArray.new.count.should eq(0)
    NSMutableArray.new.tap do |a|
      a << "foo".to_nsstring
      a.count.should eq(1)
    end
  end

  it "index" do
    NSMutableArray.new.tap do |a|
      a << "foo".to_nsstring
      a[0].is_a?(NSString).should eq(true)
      a[0].to_s.should eq("foo")
    end
  end
end
