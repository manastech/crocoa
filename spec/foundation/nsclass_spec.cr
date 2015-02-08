describe "NSClass" do
  it "name" do
    NSClass.new("NSString").name.should eq("NSString")
  end

  it "should get superclass" do
    NSClass.new("NSString").superclass.not_nil!.name.should eq("NSObject")
  end

  it "should get nil superclass on NSObject" do
    NSClass.new("NSObject").superclass.should be_nil
  end
end
