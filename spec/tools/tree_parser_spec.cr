require "../spec_helper"
require "../../src/tools/tree_parser"

def c(enumerable)
  enumerable.compact_map do |e|
    e.raw
  end
end

def pt(source)
  TreeParser.new(StringIO.new(source))
end

describe TreeParser do
  it "should return root" do
    pt(
"Root
|-Child1
|-Child2
`-Child3
").root.raw.should eq("Root")
  end

  it "should return childs" do
    pt(
"Root
|-Child1
|-Child2
`-Child3
").root.childs.map(&.raw).should eq(["Child1", "Child2", "Child3"])
  end

  it "should return childs" do
    t = pt(
"Root
|-Child1
| `-Child11
|-Child2
`-Child3
")
    t.root.childs.map(&.raw).should eq(["Child1", "Child2", "Child3"])
    t.root.childs.first.childs.map(&.raw).should eq(["Child11"])
  end

  it "should find node" do
    t = pt(
"Root
|-A
| `-B
|-C
`-D
")
    res = [] of String
    t.root.find_node(/B/, -> (node : Tree) {
      res << node.raw
    })
    res.should eq(["B"])
  end
end
