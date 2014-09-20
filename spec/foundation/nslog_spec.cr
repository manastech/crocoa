require "../spec_helper"

describe "NSLog" do
  it "can be called with just a string" do
    Crocoa.nslog "Lorem ipsum"
  end
end
