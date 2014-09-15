require "../spec_helper"

describe "Int" do
  it "should be sent as itself" do
    1.to_objc.should eq(1)
  end
end

describe "Extensions" do
  class ValueBox
    def initialize(@value)
    end

    def to_objc
      @value
    end
  end

  it "should map to_objc" do
    {ValueBox.new(1), ValueBox.new("qwerty")}.map_to_objc.should eq({1, "qwerty"})
  end
end
