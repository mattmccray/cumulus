module Loci::Resources

=begin

Layouts could have meta tags, but only at the root level? 

  /meta

Should it use a decorator approach?

<meta name="decorates" content="page"/>

???
=end


# A layout is any .html file that contains Liquid markup 
# for use in wrapping content objects.
class Layout < Template

  def initialize(fullpath)
    super(fullpath)
    @content_path = 'skin/layouts'
    @content_type = :layout
  end

end

end