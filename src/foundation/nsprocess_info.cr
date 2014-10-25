module Crocoa
  class NSProcessInfo < NSObject
    objc_init_method "processInfo", "process_info"

    objc_method "processName", nil, "NSString", "process_name"
  end
end
