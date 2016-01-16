require_relative 'dom_tree.rb'
require_relative 'parse_tag.rb'

class DOMParser
  attr_accessor :html_string, :tree, :tag_list

    TAG_REGEX = /<.*?>/
    TAG_TEXT_REGEX = />(.*?)</m
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
    string = " " * 2 * tree_node.depth
    string += "<#{tree_node.info.type}"
    string += " class=#{tree_node.info.classes}" unless tree_node.info.classes.nil?
    string += " id=#{tree_node.info.id}" unless tree_node.info.id.nil?
    string += " name=#{tree_node.info.name}" unless tree_node.info.name.nil?
    string += ">"
    string += " #{tree_node.info.text}"
    puts string

    tree_node.children.each do |child|
      render_tag_tree(child)
    end
  end

  def convert_tag_to_node(tag)
    parsed_info = ParseTag.new(tag)
    info = Tag.new(parsed_info.type, parsed_info.id, parsed_info.classes, parsed_info.name, parsed_info.text)
    DOMTreeNode.new(info, nil, [], 0)
  end

  def get_text_for_node(node)

  end

  def add_tags_to_tree
    tag_list = @html_string.scan(TAG_REGEX)
    text_list = @html_string.scan(TAG_TEXT_REGEX)

    tag_list.each_with_index do |tag, index|
      tag_node = convert_tag_to_node(tag)
      tag_node_text = text_list[index].to_s[2..-3]
      tag_node_text.gsub!(/\s{2,}/m, "") unless tag_node_text.nil?
      tag_node_text.tr!("\n", "") unless tag_node_text.nil?
      tag_node.info.text = tag_node_text

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
# d.render_tag_tree
# d_basic.render_tag_tree