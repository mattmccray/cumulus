module Cumulus::Resources

# A attachment is any file that's not the index.html in a 
# content object folder
class Attachment < BaseResource

  attr_reader :full_path, :parent
  
  def initialize(filepath, content_object)
    @parent = content_object
    @content_type = :attachment
    @full_path = filepath
    @content_path = parent.content_path
    @slug = File.basename(filepath)
    
    parse_meta
  end
  
protected
  
  def parse_meta
    metadata[:filename] = File.basename(full_path)
    metadata[:ext] = File.extname(full_path)
    metadata[:mtime] = File.mtime(full_path)
    metadata[:ctime] = File.ctime(full_path)
    metadata[:size] = File.size(full_path)
  end
  
end

end