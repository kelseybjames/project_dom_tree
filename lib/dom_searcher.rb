require_relative 'dom_parser.rb'

class DOMSearcher
  attr_accessor :search_results

  def initialize(tree)
    @tree = tree
    @root = tree.root
    @current_node = @root
    @search_results = []
  end

  def search_by(node=@root, node_trait, node_trait_value)
    top_node = node

    top_node.children.each do |child|
      @current_node = child
      if node_trait == :name
        @search_results << child if child.info.name == node_trait_value
      elsif node_trait == :class
        @search_results << child if child.info.classes.include?(node_trait_value)
      elsif node_trait == :id
        @search_results << child if child.info.id == node_trait_value
      elsif node_trait == :type
        @search_results << child if child.info.type == node_trait_value
      end
      search_by(child, node_trait, node_trait_value)
    end
    @search_results
  end
end

tree = DOMParser.new("test.html").tree
searcher = DOMSearcher.new(tree)
searcher.search_by(:type, "div")