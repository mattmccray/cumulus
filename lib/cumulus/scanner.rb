require 'fileutils'

module Cumulus

class Scanner
  attr_reader :base, :content_path

  def initialize(base_path)
    @base = File.expand_path(base_path)
    raise StandardError.new("Base path must be a directory.") unless File.directory?(base)
    
  end
  
  def sweep(clear_db=true)
    @content_path = File.join(base, 'content')
    resources.clear if clear_db
    sweep_content
    sweep_templates
    sweep_layouts
  end

private
  
  def sweep_content
    Dir[File.join(content_path, '*', '*')].each do |fullpath|
      object_path = fullpath.gsub( "#{ content_path }/", '')
      collection = object_path.split('/').first
      object = Cumulus::Resources::Content.new(fullpath, object_path)
      resources.all << object
      sweep_attachments fullpath, object
    end
  end
  
  def sweep_attachments(from_path, content_object)
    Dir[File.join(from_path, '*')].each do |filename|
      next if File.basename(filename) == 'index.html'
      resources.all << Cumulus::Resources::Attachment.new(filename, content_object)
    end
  end

  def sweep_templates
    templates_path = File.join(base, 'skin', 'templates', 'objects')
    Dir[File.join(templates_path, '*')].each do |fullpath|
      template = Cumulus::Resources::Template.new(fullpath)
      resources.all << template
    end
  end

  def sweep_layouts
    layouts_path = File.join(base, 'skin', 'templates', 'layouts')
    Dir[File.join(layouts_path, '*')].each do |fullpath|
      layout = Cumulus::Resources::Layout.new(fullpath)
      resources.all << layout
    end
  end
  
  def resources
    Cumulus::Resources
  end

end



end