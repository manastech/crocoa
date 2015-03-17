module Crocoa
  class NSString < NSObject
    import_class "NSString"
    
    #
    # (-) stringWithoutAmpersand
    # @16@0:8 (@)
    #
    def string_without_ampersand
      
      res = Crocoa.send_msg(to_objc, "stringWithoutAmpersand")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) CAMLType
    # @16@0:8 (@)
    #
    def caml_type
      
      res = Crocoa.send_msg(to_objc, "CAMLType")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) isNSString__
    # c16@0:8 (c)
    #
    def is_ns_string__
      
      res = Crocoa.send_msg(to_objc, "isNSString__")
      
      
      res.address.chr
      
      
    end
    
    #
    # (-) fastestEncoding
    # Q16@0:8 (Q)
    #
    def fastest_encoding
      
      res = Crocoa.send_msg(to_objc, "fastestEncoding")
      
      
      res.address
      
      
    end
    
    #
    # (-) smallestEncoding
    # Q16@0:8 (Q)
    #
    def smallest_encoding
      
      res = Crocoa.send_msg(to_objc, "smallestEncoding")
      
      
      res.address
      
      
    end
    
    #
    # (-) decomposedStringWithCompatibilityMapping
    # @16@0:8 (@)
    #
    def decomposed_string_with_compatibility_mapping
      
      res = Crocoa.send_msg(to_objc, "decomposedStringWithCompatibilityMapping")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) precomposedStringWithCompatibilityMapping
    # @16@0:8 (@)
    #
    def precomposed_string_with_compatibility_mapping
      
      res = Crocoa.send_msg(to_objc, "precomposedStringWithCompatibilityMapping")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) cStringLength
    # Q16@0:8 (Q)
    #
    def c_string_length
      
      res = Crocoa.send_msg(to_objc, "cStringLength")
      
      
      res.address
      
      
    end
    
    #
    # (-) lossyCString
    # r*16@0:8 (r*)
    #
    def lossy_cString
      
      res = Crocoa.send_msg(to_objc, "lossyCString")
      
      
      String.new(res.address)
      
      
    end
    
    #
    # (-) quotedStringRepresentation
    # @16@0:8 (@)
    #
    def quoted_string_representation
      
      res = Crocoa.send_msg(to_objc, "quotedStringRepresentation")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) stringByConvertingPathToURL
    # @16@0:8 (@)
    #
    def string_by_converting_path_to_uRL
      
      res = Crocoa.send_msg(to_objc, "stringByConvertingPathToURL")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) stringByConvertingURLToPath
    # @16@0:8 (@)
    #
    def string_by_converting_url_to_path
      
      res = Crocoa.send_msg(to_objc, "stringByConvertingURLToPath")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) propertyListFromStringsFileFormat
    # @16@0:8 (@)
    #
    def property_list_from_strings_file_format
      
      res = Crocoa.send_msg(to_objc, "propertyListFromStringsFileFormat")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) formatConfiguration
    # @16@0:8 (@)
    #
    def format_configuration
      
      res = Crocoa.send_msg(to_objc, "formatConfiguration")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) stringByAddingPercentEscapes
    # @16@0:8 (@)
    #
    def string_by_adding_percent_escapes
      
      res = Crocoa.send_msg(to_objc, "stringByAddingPercentEscapes")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) standardizedURLPath
    # @16@0:8 (@)
    #
    def standardized_url_path
      
      res = Crocoa.send_msg(to_objc, "standardizedURLPath")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) stringByRemovingPercentEncoding
    # @16@0:8 (@)
    #
    def string_by_removing_percent_encoding
      
      res = Crocoa.send_msg(to_objc, "stringByRemovingPercentEncoding")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) significantText
    # {_NSRange=QQ}16@0:8 ({_NSRange=QQ})
    #
    def significant_text
      
      raise "return type '{_NSRange=QQ}' not supported"
      
    end
    
    #
    # (-) precomposedStringWithCanonicalMapping
    # @16@0:8 (@)
    #
    def precomposed_string_with_canonical_mapping
      
      res = Crocoa.send_msg(to_objc, "precomposedStringWithCanonicalMapping")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) cString
    # r*16@0:8 (r*)
    #
    def c_string
      
      res = Crocoa.send_msg(to_objc, "cString")
      
      
      String.new(res.address)
      
      
    end
    
    #
    # (-) stringByRemovingPercentEscapes
    # @16@0:8 (@)
    #
    def string_by_removing_percent_escapes
      
      res = Crocoa.send_msg(to_objc, "stringByRemovingPercentEscapes")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) stringByDeletingPathExtension
    # @16@0:8 (@)
    #
    def string_by_deleting_path_extension
      
      res = Crocoa.send_msg(to_objc, "stringByDeletingPathExtension")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) lastPathComponent
    # @16@0:8 (@)
    #
    def last_path_component
      
      res = Crocoa.send_msg(to_objc, "lastPathComponent")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) hash
    # Q16@0:8 (Q)
    #
    def hash
      
      res = Crocoa.send_msg(to_objc, "hash")
      
      
      res.address
      
      
    end
    
    #
    # (-) description
    # @16@0:8 (@)
    #
    def description
      
      res = Crocoa.send_msg(to_objc, "description")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) length
    # Q16@0:8 (Q)
    #
    def length
      
      res = Crocoa.send_msg(to_objc, "length")
      
      
      res.address
      
      
    end
    
    #
    # (-) doubleValue
    # d16@0:8 (d)
    #
    def double_value
      
      res = Crocoa.send_msg_fpret(to_objc, "doubleValue")
      
      
      res
      
      
    end
    
    #
    # (-) boolValue
    # c16@0:8 (c)
    #
    def bool_value
      
      res = Crocoa.send_msg(to_objc, "boolValue")
      
      
      res.address.chr
      
      
    end
    
    #
    # (-) integerValue
    # q16@0:8 (q)
    #
    def integer_value
      
      res = Crocoa.send_msg(to_objc, "integerValue")
      
      
      res.address
      
      
    end
    
    #
    # (-) floatValue
    # f16@0:8 (f)
    #
    def float_value
      
      res = Crocoa.send_msg_float32(to_objc, "floatValue")
      
      
      res
      
      
    end
    
    #
    # (-) UTF8String
    # r*16@0:8 (r*)
    #
    def uTF8String
      
      res = Crocoa.send_msg(to_objc, "UTF8String")
      
      
      String.new(res.address)
      
      
    end
    
    #
    # (-) longLongValue
    # q16@0:8 (q)
    #
    def long_long_value
      
      res = Crocoa.send_msg(to_objc, "longLongValue")
      
      
      res.address
      
      
    end
    
    #
    # (-) fileSystemRepresentation
    # r*16@0:8 (r*)
    #
    def file_system_representation
      
      res = Crocoa.send_msg(to_objc, "fileSystemRepresentation")
      
      
      String.new(res.address)
      
      
    end
    
    #
    # (-) pathExtension
    # @16@0:8 (@)
    #
    def path_extension
      
      res = Crocoa.send_msg(to_objc, "pathExtension")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) lowercaseString
    # @16@0:8 (@)
    #
    def lowercase_string
      
      res = Crocoa.send_msg(to_objc, "lowercaseString")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) stringByResolvingSymlinksInPath
    # @16@0:8 (@)
    #
    def string_by_resolving_symlinks_in_path
      
      res = Crocoa.send_msg(to_objc, "stringByResolvingSymlinksInPath")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) intValue
    # i16@0:8 (i)
    #
    def int_value
      
      res = Crocoa.send_msg(to_objc, "intValue")
      
      
      res.address
      
      
    end
    
    #
    # (-) uppercaseString
    # @16@0:8 (@)
    #
    def uppercase_string
      
      res = Crocoa.send_msg(to_objc, "uppercaseString")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) classForCoder
    # #16@0:8 (#)
    #
    def class_for_coder
      
      res = Crocoa.send_msg(to_objc, "classForCoder")
      
      
      NSClass.new(res.address as LibObjC::Class)
      
      
    end
    
    #
    # (-) stringByDeletingLastPathComponent
    # @16@0:8 (@)
    #
    def string_by_deleting_last_path_component
      
      res = Crocoa.send_msg(to_objc, "stringByDeletingLastPathComponent")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) stringByStandardizingPath
    # @16@0:8 (@)
    #
    def string_by_standardizing_path
      
      res = Crocoa.send_msg(to_objc, "stringByStandardizingPath")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) pathComponents
    # @16@0:8 (@)
    #
    def path_components
      
      res = Crocoa.send_msg(to_objc, "pathComponents")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) stringByExpandingTildeInPath
    # @16@0:8 (@)
    #
    def string_by_expanding_tilde_in_path
      
      res = Crocoa.send_msg(to_objc, "stringByExpandingTildeInPath")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) isAbsolutePath
    # c16@0:8 (c)
    #
    def is_absolute_path
      
      res = Crocoa.send_msg(to_objc, "isAbsolutePath")
      
      
      res.address.chr
      
      
    end
    
    #
    # (-) stringByAbbreviatingWithTildeInPath
    # @16@0:8 (@)
    #
    def string_by_abbreviating_with_tilde_in_path
      
      res = Crocoa.send_msg(to_objc, "stringByAbbreviatingWithTildeInPath")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) capitalizedString
    # @16@0:8 (@)
    #
    def capitalized_string
      
      res = Crocoa.send_msg(to_objc, "capitalizedString")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) propertyList
    # @16@0:8 (@)
    #
    def property_list
      
      res = Crocoa.send_msg(to_objc, "propertyList")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) decomposedStringWithCanonicalMapping
    # @16@0:8 (@)
    #
    def decomposed_string_with_canonical_mapping
      
      res = Crocoa.send_msg(to_objc, "decomposedStringWithCanonicalMapping")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) displayableString
    # @16@0:8 (@)
    #
    def displayable_string
      
      res = Crocoa.send_msg(to_objc, "displayableString")
      
      
      AnyObject.new(res)
      
      
    end
    
    #
    # (-) decimalValue
    # {?=b8b4b1b1b18[8S]}16@0:8 ({?=b8b4b1b1b18[8S]})
    #
    def decimal_value
      
      raise "return type '{?=b8b4b1b1b18[8S]}' not supported"
      
    end
    
  end
end
