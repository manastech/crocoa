require "../spec_helper"

describe "NSMenu" do
  it "can be created" do
    Crocoa::NSMenu.new "aTitle"
  end
end
