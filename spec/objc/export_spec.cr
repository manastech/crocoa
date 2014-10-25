require "../spec_helper"

describe "export" do

  objc_class :MyFooBar do
    property x

    def initialize
      previous_def
      @x = 5
    end

    def initialize(s : UInt8*)
      previous_def
      @x = 5
    end

    def inc
      x = @x || 0 # compilation issues
      x += 1

      @x = x
    end
    objc_export inc
  end

  it "should register classes" do
    NSClass.new("MyFooBar").name.should eq("MyFooBar")
    MyFooBar.nsclass.name.should eq("MyFooBar")
  end

  it "should keep identity of object created from crystal" do
    o = MyFooBar.new
    o.x.should eq(5)
    Crocoa.send_msg(o.to_objc, "inc")
    o.x.should eq(6)
  end

  it "should keep identity of object created from objc" do
    obj = Crocoa.send_msg(MyFooBar.nsclass.send_msg("alloc"), "init")
    Crocoa.send_msg(obj, "inc")
    o = LibObjC.objc_getAssociatedObject(obj, $x_MyFooBar_assoc_key) as MyFooBar
    o.x.should eq(6)

    Crocoa.send_msg(obj, "inc")
    o.x.should eq(7)
  end

end
