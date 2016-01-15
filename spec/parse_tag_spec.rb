require_relative '../lib/parse_tag'

describe ParseTag do
  let (:tag_string) { "<p class='foo bar' id='baz' name='fozzie'>" }
  let (:new_tag) { ParseTag.new(tag_string) }

  let(:tag_string_without_name) { "<p class='foo bar' id='baz'>" }
  let(:new_tag_without_name) { ParseTag.new(tag_string_without_name) }

  let(:simple_tag_string) { "<html>" }
  let(:simple_tag) { ParseTag.new(simple_tag_string) }

  describe '#initialize' do
    it 'creates the tag type' do
      expect(new_tag.type).to eq("p")
    end

    it 'creates the tag classes' do
      expect(new_tag.classes).to eq(["foo", "bar"])
    end

    it 'creates the tag id' do
      expect(new_tag.id).to eq("baz")
    end

    it 'creates the tag name' do
      expect(new_tag.name).to eq("fozzie")
    end

    it 'creates the tag without a name if none is given' do
      expect(new_tag_without_name.name).to eq(nil)
    end

    it 'works on simple tags' do
      expect(simple_tag.type).to eq("html")
    end
  end
end