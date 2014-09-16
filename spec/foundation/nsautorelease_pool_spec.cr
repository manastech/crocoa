require "../spec_helper"

describe "NSAutoreleasePool" do
  it "can be created" do
    Crocoa::NSAutoreleasePool.new
  end
end
