module Loci::Resources

# A layout is any .html file that contains Liquid markup 
# for use in wrapping content objects.
class Layout < Template

  def initialize(fullpath)
    super(fullpath, false)
    @content_path = 'skin/layouts'
    @content_type = :layout
    parse_template(fullpath, false)
  end

end

end