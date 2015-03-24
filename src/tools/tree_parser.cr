require "colorize"

class Tree
  getter raw
  getter childs
  getter parent

  def initialize(raw, @parent = nil)
    @raw = raw.strip
    @childs = [] of Tree
  end

  def <<(child)
    @childs << child
  end

  def kind
    raw.split.first
  end

  def find_node(regex, proc)
    # puts print_node
    if raw =~ regex
      proc.call(self)
    else
      childs.each do |node|
        node.find_node(regex, proc)
      end
    end
  end

  def level
    @level ||= parent.nil? ? 0 : (parent.not_nil!.level + 1)
  end

  def print_trace(io, colorized = true)
    if parent
      parent.not_nil!.print_trace(io, false)
    end
    print_node(io, colorized)
  end

  def print_trace_and_children(childs_level, io)
    print_trace(io)
    print_children(childs_level, io)
  end

  def print_children(childs_level, io)
    if childs_level > 0
      childs.each do |node|
        node.print_node(io)
        node.print_children(childs_level-1, io)
      end
    end
  end

  def print_node(io, colorized = false)
    if colorized
      with_color.green.surround(io) do
        io << "#{"  " * level}#{raw}"
        io << '\n'
      end
    else
      io << "#{"  " * level}#{raw}"
      io << '\n'
    end
  end

  def print_trace
    io = StringIO.new
    print_trace(io)
    io.to_s
  end

  def to_s(io)
    print_trace(io)
  end

  def find_class_related(nsclass_name, proc)
    # ObjCInterfaceDecl migth be needed to be returned also
    find_node(Regex.new("^ObjCInterface .*#{nsclass_name}"), proc)
  end

  def find_methods_related(nsclass_name, proc)
    find_class_related(nsclass_name, ->(node: Tree) {
      if node.kind == "ObjCInterface"
        # ObjCInterface has ObjCMethodDecl as siblings, not child
        node = node.next_sibling
        while node && node.kind == "ObjCMethodDecl"
          proc.call(node)
          node = node.next_sibling if node
        end
      else
        raise "not implemented '#{node.kind}'"
      end
    })
  end

  def next_sibling
    prev = nil
    parent.not_nil!.childs.each do |node|
      if prev == self
        return node
      end
      prev = node
    end
    nil
  end
end

class TreeParser
  getter root

  def initialize(buffer)
    @root = Tree.new(buffer.gets.not_nil!)
    last_node = @root

    parents = [] of Tree
    buffer.each_line do |line|
      node_level = (line.index('-').not_nil! + 1) / 2

      if node_level > parents.length
        parents.push last_node
      elsif node_level < parents.length
        parents.pop
      end

      last_node = Tree.new(line[node_level*2..-1], parents.last)
      parents.last << last_node
    end
  end
end

