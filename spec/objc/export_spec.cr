require "../spec_helper"

describe "export" do

  objc_class :MyFooBar do
  end

  it "should register classes" do
    NSClass.new("MyFooBar").name.should eq("MyFooBar")
  end

end
