require "../src/crocoa"
include Crocoa

{{`ibtool --errors --warnings --notices --output-format human-readable-text --compile Application.nib Application.xib`}}

mainNib = NSNib.new "Application", NSBundle.main_bundle

mainNib.instantiate_nib_with_owner_top_level_objects NSApp, nil

NSApp.perform_selector_on_main_thread_with_object_wait_until_done "run", nil, true
# NSApp.run
