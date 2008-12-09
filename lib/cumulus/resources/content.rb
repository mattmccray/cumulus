require 'hpricot'

module Cumulus::Resources

# Content objects reside within collections, they include all meta data
# and attachments
class Content < BaseResource
  
  
  def initialize(full_path, content_path)
    super(full_path)
    @content_type = :content
    @content_path = content_path
    @collection_type = content_path.split('/').first
    parse_file
  end
  
  def attachments
    Cumulus::Resources.attachments( :in_collection=>content_path )
  end
  
protected

  def parse_file(filename='index.html')
    doc = Hpricot(open(File.join(source_path, filename)))
    metadata[:title] = doc.at("title").inner_html
    doc.search("//title").remove

    metadata[:content] = doc.at("body").inner_html #.squeeze
    doc.search("//body").remove

    doc.search("//meta").each do |meta_tag|
      name = meta_tag[:name].gsub(' ', '_').gsub('-', '_').downcase.to_sym
      if name == :include
        metadata[name] = [] unless metadata.has_key? name
        metadata[name] << meta_tag[:content]
      else
        metadata[name] = meta_tag[:content]
      end
      
    end
    doc.search("//meta").remove

    # Whatever's left in the header, we'll pull out here...
    metadata[:head] =  doc.at("head").inner_html.squeeze
  end
  
end

end