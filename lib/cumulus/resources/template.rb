module Cumulus::Resources

# A template is any .html file that contains Liquid markup 
# for use in wrapping/rendering content objects
class Template < BaseResource
  
  def initialize(fullpath)
    super(fullpath)
    @content_type = :template
    @content_path = 'skin/templates'
    parse_template
  end
  
protected
  
  def parse_template
    doc = Hpricot(open(source_path))

    doc.search("/meta").each do |meta_tag|
      name = meta_tag[:name].gsub(' ', '_').gsub('-', '_').downcase.to_sym
      if name == :include or metadata.has_key? name
        metadata[name] = [ metadata[name] ] unless metadata[name].is_a? Array
        metadata[name] << meta_tag[:content]
      else
        metadata[name] = meta_tag[:content]
      end
    end
    doc.search("/meta").remove
    
    metadata[:content] = doc.to_s
  end
  
end

end