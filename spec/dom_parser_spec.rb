require_relative '../lib/dom_parser'
require_relative '../lib/dom_tree'

describe DOMParser do

  let(:new_parser) { DOMParser.new('test.html')}
  let(:simple_string) { '<html>Test</html>'}

  describe '#initialize' do
    it 'initializes with html_string' do
      expect(new_parser.html_string).to be_an_instance_of(String)
    end
  end

  describe '#convert_string' do
    xit 'creates tree with html root' do
      new_parser.convert_string(simple_string)
      expect (new_parser.tree.root).to be_an_instance_of(DOMTreeNode)
    end
  end

  describe '#add_tags_to_tree' do
    it 'populates tree' do
      new_parser.add_tags_to_tree
      expect(new_parser.tree).to be_an_instance_of(DOMTree)
    end
  end

end