require_relative 'dom_tree.rb'
require_relative 'parse_tag.rb'

class DOMParser
  attr_accessor :html_string, :tree, :tag_list

    TAG_REGEX = /<.*?>/
    GREEDY_TAG_REGEX = /<.*>(.*)<\/.*>/
    GREEDY_OPEN_TAG_REGEX = /<[^\/].*>/
    OPEN_TAG_REGEX = /<[^\/].*?>/
    CLOSE_TAG_REGEX = /<\/.*?>/
    OPEN_HTML_TAG_REGEX = /<html>/
    CLOSE_HTML_TAG_REGEX = /<\/html>/

  def initialize(file)
    @html_string = File.read(file)[16..-1] # ignores doctype declaration
    @tree = DOMTree.new
    add_tags_to_tree
  end

  def tag_type(string)
    return "open" if string =~ OPEN_TAG_REGEX
    return "closed" if string =~ CLOSE_TAG_REGEX
  end

  # for each node, print first child depth first
  def render_tag_tree(tree_node=@tree.root)
    puts (" " * 2 * tree_node.depth) + "#{tree_node.info.type}"
    tree_node.children.each do |child|
      render_tag_tree(child)
    end
  end

  def convert_tag_to_node(tag)
    parsed_info = ParseTag.new(tag)
    info = Tag.new(parsed_info.type, parsed_info.id, parsed_info.classes, parsed_info.name, parsed_info.text)
    DOMTreeNode.new(info, nil, [], 0)
  end

  def add_tags_to_tree(string=@html_string)
    tag_list = string.scan(TAG_REGEX)
    puts tag_list
    tag_list.each do |tag|
      tag_node = convert_tag_to_node(tag)
      if tag_type(tag) == 'open'
        if @tree.root == nil
          tag_node.depth = 0
          @tree.root = tag_node
        else
          @tree.open_new_node(tag_node)
        end
      elsif tag_type(tag) == 'closed'
        @tree.close_node
      else
        raise ArgumentError.new("Weird tag!")    
      end
    end
  end
end


d = DOMParser.new("test.html")
# d_basic = DOMParser.new("basictest.html")
d.render_tag_tree
# d_basic.render_tag_tree