class ParseTag 
  attr_accessor :type, :id, :classes, :name, :text

  TAG_TEXT_REGEX = />(.*?)</m

  def initialize(tag_string=nil, file_string="")
    @type = parse_type(tag_string)
    @id = parse_id(tag_string)
    @classes = parse_classes(tag_string)
    @name = parse_name(tag_string)
    @text = parse_text(tag_string, file_string)
  end

  def parse_type( tag_string )
    type = tag_string.match(/<(.*?)[ >]/)[1]
    type
  end

  def parse_id( tag_string )
    return nil if tag_string.match(/id=['"](.*?)['"]/).nil?
    id_string = tag_string.match(/id=['"](.*?)['"]/)[1]
    id_string = id_string.to_s
    id_string
  end

  def parse_classes( tag_string )
    return nil if tag_string.match(/class=['"](.*?)['"]/).nil?
    classes_string = tag_string.match(/class=['"](.*?)['"]/)[1]
    classes_string = classes_string.to_s
    classes_array = classes_string.split(" ")
    classes_array
  end

  def parse_name( tag_string )
    return nil if tag_string.match(/name=['"](.*?)['"]/).nil?
    name_string = tag_string.match(/name=['"](.*?)['"]/)[1]
    name_string = name_string.to_s unless name_string == nil
    name_string
  end

  def parse_text( tag_string, file_string )
    return nil if file_string.match(TAG_TEXT_REGEX).nil?
    @text = file_string.match(TAG_TEXT_REGEX)[1]
  end

end
