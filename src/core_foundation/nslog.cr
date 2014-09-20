module Crocoa
  def self.nslog(format : String|NSString)
    LibCF.nslog(format.to_nsstring.to_objc)
  end
end
