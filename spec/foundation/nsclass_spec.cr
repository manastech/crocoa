require "../spec_helper"

describe "NSClass" do
  it "name" do
    NSClass.new("NSString").name.should eq("NSString")
  end
end
