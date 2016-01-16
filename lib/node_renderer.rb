require_relative 'dom_parser.rb'

class NodeRenderer

  def initialize(tree)
    @tree = tree
    @root = @tree.root
    @current_node = @root
    @total_children = []
  end

  def render(node)
    puts "Type: #{node.info.type.inspect}"
    puts "Classes: #{node.info.classes.inspect}"
    puts "ID: #{node.info.id.inspect}"
    puts "Name: #{node.info.name.inspect}"
    puts "====================="
    puts "Total nodes below this node: #{subtree(node)}"
    node_types = subtree_types(node)
    node_types.each { |type| puts "Number of #{type[0]}: #{type[1]}" }
  end

  def subtree(top_node)
    # returns total number of nodes in subtree
    top_node = @root if top_node == nil
    top_node.children.each do |child|
      @current_node = child
      @total_children << child
      subtree(@current_node)
    end
    @total_children.length
  end

  def subtree_types(top_node)
    subtree(top_node)
    node_types = {}

    @total_children.each do |child|
      type = child.info.type
      node_types.has_key?(type) ? node_types[type] += 1 : node_types[type] = 0
    end
    node_types
  end
end

tree = DOMParser.new("test.html").tree
renderer = NodeRenderer.new(tree)
renderer.render(tree.root.children[1])