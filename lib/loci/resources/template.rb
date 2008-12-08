module Loci::Resources

# A template is any .html file that contains Liquid markup 
# for use in wrapping/rendering content objects
class Template < BaseResource
  
  attr_reader :full_path
  
  def initialize(fullpath, auto_parse=true)
    @full_path = fullpath
    @content_type = :template
    @content_path = 'skin/templates'
    @slug = File.basename(fullpath)
    parse_template(fullpath) if auto_parse
  end
  
protected
  
  def parse_template(filename, parse_meta=true)
    doc = Hpricot(open(filename))

    if parse_meta
      doc.search("//meta").each do |meta_tag|
        name = meta_tag[:name].gsub(' ', '_').gsub('-', '_').downcase.to_sym
        metadata[ name ] = meta_tag[:content]
      end
      doc.search("//meta").remove
    end
    
    metadata[:content] = doc.to_s
  end
  
end

end