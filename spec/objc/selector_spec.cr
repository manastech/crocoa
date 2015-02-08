describe "Selector" do
  it "is initialized by name" do
    Selector.new("performSelector:withObject:afterDelay:").name.should eq("performSelector:withObject:afterDelay:")
  end
end
