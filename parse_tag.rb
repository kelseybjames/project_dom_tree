Tag = Struct.new( :type, :id, :classes, :name  )

def parse_tag( tag_string )
  tag = Tag.new(parse_type(tag_string), parse_id(tag_string), parse_classes(tag_string), parse_name(tag_string))
  tag
end

def parse_type( tag_string )
  type = tag_string.match(/<(.*?) /)[1]
  type
end

def parse_classes( tag_string )
  classes_string = tag_string.match(/class='(.*?)'/)[1].to_s
  puts classes_string
  classes_array = classes_string.split(" ")
  classes_array
end

def parse_id( tag_string )
  id_string = tag_string.match(/id='(.*?)'/)[1].to_s
  id_string
end

def parse_name( tag_string )
  name_string = tag_string.match(/name='(.*?)'/)[1].to_s
  name_string
end

tag_string = "<p class='foo bar' id='baz' name='fozzie'>"
# puts parse_type(tag_string)
# puts parse_classes(tag_string)
# puts parse_id(tag_string)
# puts parse_name(tag_string)

puts parse_tag(tag_string)