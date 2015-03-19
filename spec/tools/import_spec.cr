require "../spec_helper"
require "../../src/tools/import"

def cmf(sel)
  Import.crystal_method_for(sel)
end

describe Import do
  describe "crystal_method_for" do
    it "" { cmf("theMethod").should eq("the_method") }
    it "" { cmf("stringWithoutAmpersand").should eq("string_without_ampersand") }
    it "" { cmf("CAMLType").should eq("caml_type") }
    it "" { cmf("stringByConvertingPathToURL").should eq("string_by_converting_path_to_url") }
    it "" { cmf("UTF8String").should eq("utf8_string") }
    it "" { cmf("stringByConvertingURLToPath").should eq("string_by_converting_url_to_path") }
  end
end
