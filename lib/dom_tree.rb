require_relative 'parse_tag.rb'
require_relative 'tag.rb'

DOMTreeNode = Struct.new( :info, :parent, :children, :depth )

class DOMTree

  attr_accessor :root, :current_open_node

  def initialize
    @root = nil
    @current_open_node = @root
  end

  def root=(new_node)
    @root = new_node
    @current_open_node = @root
  end

  def get_children
    @current_open_node.children
  end

  def add_info_to_open_node(tag_string)
    @current_open_node.info = ParseTag(tag_string)
  end

  def add_text_to_open_node(new_text)
    @current_open_node.info.text << new_text
  end

  def open_new_node(node)
    node.depth = @current_open_node.depth + 1
    node.parent = @current_open_node
    @current_open_node.children << node
    @current_open_node = node
  end

  def close_node
    @current_open_node = @current_open_node.parent unless current_open_node.parent == nil
  end
end
