module Crocoa
  class NSNib < NSObject
    objc_method "initWithNibNamed:bundle:", [:NSString, :NSBundle], :id, "initialize"

    # fix NSArray**
    objc_method "instantiateWithOwner:topLevelObjects:", [:id, :NSArray], :BOOL, "instantiate_nib_with_owner_top_level_objects"
    # - (BOOL)instantiateWithOwner:(id)owner topLevelObjects:(NSArray **)topLevelObjects

  end
end
