module Cumulus::Resources

=begin

content_path:
  - pages/about
  - posts/20081105-my-slugline

content_type:
  - content
  - attachment

collection_type:
  - pages
  - posts

slug:
  - about
  - 20081105-my-slugline

=end
  
class BaseResource

  attr_reader :slug, :content_path, :collection_type, :content_type, :source_path

  # def guid
  #   @guid ||= `uuidgen` # Probably need a more portable solution than this...
  # end
  
  def initialize(fullpath)
    @source_path = fullpath
    @slug = File.basename(fullpath)
  end
  
  def metadata
    @meta ||= {}
  end
  
  def includes
    metadata.fetch(:include, [])
  end
  
  def output_path
    #filename = File.extname(@slug).empty? ? "#{@slug}.html" : @slug
    File.join(Cumulus.output_dir, @collection_type, @slug, 'index.html')
  end
  
  def method_missing(name, *args)
    if name.to_s.ends_with? '='
      metadata[name.to_s[0..-2].to_sym] = args.first
    else
      metadata[name]
    end
  end
  
  def <=>( other )
    return unless other.kind_of? ::Cumulus::Resources::BaseResource
    self.content_path <=> other.content_path
  end
  
  def to_liquid
    data = metadata.merge({
      :slug => @slug,
      :content_path => @content_path,
      :collection_type => @collection_type,
      :content_type => @content_type
    }).stringify_keys
  end
  
  def [](key)
    if self.respond_to? key.to_sym
      self.send(key.to_sym)
    else
      metadata[name]
    end
  end
  
  # def dirty?
  #   return metadata[:dirty] if metadata.has_key? :dirty
  # 
  #   # if the destination file does not exist, then we are dirty
  #   return true unless test(?e, destination)
  # 
  #   # if this file's mtime is larger than the destination file's
  #   # mtime, then we are dirty
  #   dirty = @mtime > ::File.mtime(destination)
  #   return dirty if dirty
  # 
  #   # check to see if the layout is dirty, and if it is then we
  #   # are dirty, too
  #   if _meta_data.has_key? 'layout'
  #     lyt = ::Webby::Resources.find_layout(_meta_data['layout'])
  #     unless lyt.nil?
  #       return true if lyt.dirty?
  #     end
  #   end
  # 
  #   # if we got here, then we are not dirty
  #   false
  # end
  
end

end