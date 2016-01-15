# project_dom_tree
Like leaves on the wind

[A data structures, algorithms, file I/O, ruby and regular expression (regex) project from the Viking Code School](http://www.vikingcodeschool.com)

John and Kelsey

-------------------

Thu 4:30/6:30

TTD

do dom parser

update parse_tag class
    1. build regex to differentiate open tag from closing tag

build tree structure


------------------


-------------------------------
Parse DOM/HTML file pseducode
------------------------------
class ReadFile

    def run
        line_array = file readlines
        line_array.each line
            handle_line
        end
    end

    def handle_line
        case OpenTag
            parse OpenTag
        case Text
            find parent Tag
            update TagInfo
        case CloseTag
            update DOM
    end
end


class DOMTree
    head

    create_node
    attach_node
-------
    get_children( node )

end

Node = new Struct( tag_info, parent, children )


##################


<html> # tag match

####run this

match = filestring.match(our_regex)

##### expect

match.pre_match == ""
match.to_s == "<html>"
match.post_match != "<html>""


##############

each iteration we match on an HTML regex tag


desired parsing behavior (wrt test.html)

1. create html node (no attributes)
2. create head node (no attributes)
3. create title node 
4. Add text to title node
5. close title node
6. close head node
.....


Don't recurse! Generate the list of tag nodes with depth first.
render should do a depth first search of the tree.