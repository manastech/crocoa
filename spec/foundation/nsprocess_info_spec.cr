def pi
  NSProcessInfo.process_info
end

describe "NSProcessInfo" do

  it "can be created" do
    pi
  end

  it "it get process_name" do
    pi.process_name.to_s.should_not eq("")
  end
end
