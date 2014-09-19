require "../spec_helper"

macro describe_nscontrol(new_control)
  it "can be created" do
    {{new_control}}
  end

  # it "string_value can be get/set" do
  #   c = {{new_control}}
  #   c.string_value = "Foo"
  #   c.string_value.to_s.should eq("Foo")
  # end

  it "action can be get/set" do
    c = {{new_control}}
    c.action = "terminate:"
    # c.action.name.should eq("terminate:")
  end

  it "target can be get/set" do
    c = {{new_control}}
    t = {{new_control}}
    c.target = t
    c.target.should eq(t)
  end
end
