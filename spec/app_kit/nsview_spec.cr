require "../spec_helper"

describe "NSView" do
  def new_view
    Crocoa::NSView.new(Crocoa::NSRect.new(0, 0, 200, 200))
  end

  it "can be created" do
    new_view
  end

  it "sub view can be added" do
    new_view << new_view
  end
end
