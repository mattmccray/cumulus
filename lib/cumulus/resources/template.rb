module Cumulus::Resources

# A template is any .html file that contains Liquid markup 
# for use in wrapping/rendering content objects
class Template < BaseResource
  
  attr_reader :full_path
  
  def initialize(fullpath)
    @full_path = fullpath
    @content_type = :template
    @content_path = 'skin/templates'
    @slug = File.basename(fullpath)
    parse_template(fullpath)
  end
  
protected
  
  def parse_template(filename)
    doc = Hpricot(open(filename))

    doc.search("/meta").each do |meta_tag|
      name = meta_tag[:name].gsub(' ', '_').gsub('-', '_').downcase.to_sym
      metadata[ name ] = meta_tag[:content]
    end
    doc.search("/meta").remove
    
    metadata[:content] = doc.to_s
  end
  
end

end