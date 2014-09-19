require "../spec_helper"

describe "NSApplication" do
  it "can be created" do
    Crocoa::NSApplication.shared_application
  end

  it "activation_policy can be set" do
    Crocoa::NSApp.activation_policy=(LibAppKit::NSApplicationActivationPolicy::Regular).should be_true
    Crocoa::NSApp.activation_policy=(LibAppKit::NSApplicationActivationPolicy::Accessory).should be_true
    Crocoa::NSApp.activation_policy=(LibAppKit::NSApplicationActivationPolicy::Prohibited).should be_true
  end

  it "activate_ignoring_other_apps can be set" do
    Crocoa::NSApp.activate_ignoring_other_apps = true
    Crocoa::NSApp.activate_ignoring_other_apps = false
  end

  it "main_menu can be set" do
    Crocoa::NSApp.main_menu = Crocoa::NSMenu.new "aTitle"
  end
end
