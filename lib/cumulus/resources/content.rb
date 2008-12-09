require 'hpricot'

module Cumulus::Resources

# Content objects reside within collections, they include all meta data
# and attachments
class Content < BaseResource
  
  attr_reader :content_dir
  
  def initialize(full_path, content_path)
    @content_type = :content
    @content_path = content_path
    @collection_type = content_path.split('/').first
    @slug = content_path.split('/').last
    @content_dir = full_path
    
    parse_file
  end
  
  def attachments
    Cumulus::Resources.attachments(:in_collection=>content_path)
  end
  
protected

  def parse_file(filename='index.html')
    doc = Hpricot(open(File.join(content_dir, filename)))
    metadata[:title] = doc.at("title").inner_html
    doc.search("//title").remove

    metadata[:content] = doc.at("body").inner_html #.squeeze
    doc.search("//body").remove

    doc.search("//meta").each do |meta_tag|
      name = meta_tag[:name].gsub(' ', '_').gsub('-', '_').downcase.to_sym
      metadata[ name ] = meta_tag[:content]
    end
    doc.search("//meta").remove

    # Whatever's left in the header, we'll pull out here...
    metadata[:head] =  doc.at("head").inner_html.squeeze
  end
  
end

end