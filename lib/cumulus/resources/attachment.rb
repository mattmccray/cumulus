module Cumulus::Resources

# A attachment is any file that's not the index.html in a 
# content object folder
class Attachment < BaseResource

  attr_reader :parent
  
  def initialize(filepath, content_object)
    super(filepath)
    @parent = content_object
    @content_type = :attachment
    @content_path = parent.content_path
    @collection_type = parent.collection_type
    parse_meta
  end
  
  def output_path
    File.join(Cumulus.output_dir, @content_path, @slug)
  end
  
  
protected
  
  def parse_meta
    metadata[:filename] = File.basename(source_path)
    metadata[:ext] = File.extname(source_path)
    metadata[:mtime] = File.mtime(source_path)
    metadata[:ctime] = File.ctime(source_path)
    metadata[:size] = File.size(source_path)
  end
  
end

end