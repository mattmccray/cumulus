# The builder class takes the resources and generates the output

require 'liquid/module_ex'

class Hash

end

module Cumulus

class Builder
  
  attr_reader :options
  
  def initialize(run_options={})
    @options = {
      :dry_run => false,
      :verbose => false
    }.merge!(run_options)
  end
  
  def execute
    collection_types = {}
    renderer = Cumulus::Renderer.new({})
    
    Resources.collections.each do |content|
      #content = content.clone
      # Render content
      output = nil
      renderer.render_body(content)
      template = renderer.template_for( content )
      output = renderer.render(template, content, {'_content' => content})
      
      # Render layout around content
      layout = renderer.layout_for(template)
      output = renderer.render(layout, output)
      
      # Write to file
      write_file content.output_path, output
      
      # Copy attachments
      content.attachments.each do |attachment|
        copy_file attachment.source_path, attachment.output_path
      end
      
      collection_types[content.collection_type] ||= []
      collection_types[content.collection_type] << content
    end
    
    collection_types.each do |coll, contents|
      # Render the collection indices...
      contents.map {|c| renderer.render_body(c) }
      template = renderer.template_for( contents.first, 'index' )
      source = renderer.render(template, '', {coll => contents, '_contents' => contents})
      
      layout = renderer.layout_for(template)
      output = renderer.render(layout, source)
      
      write_file File.join(Cumulus.output_dir, coll, 'index.html'), output
    end
  end

private
  
  def temporarily_replace(content, value, field=:content)
    old = content.metadata[field]
    content.metadata[field] = value
    yield
    content.metadata[field] = old
  end
  # Use logging?
  def info(msg, alt=nil)
    if options[:verbose]
      puts msg
    else
      puts alt unless alt.nil?
    end
  end
  
  def error
    puts msg
  end
  
  def fatal
    puts msg
  end

  # ================
  # = File Helpers =
  # ================
  
  def make_dir(path)
    FileUtils.mkdir_p( path )
  end
  
  def write_file(path, contents)
    make_dir( File.dirname( path ) )
    File.open( path, 'w' ) do |f|
      f.write( contents )
      info(" + #{ path }", '.')
    end
  end
  
  def copy_file(path, to)
    make_dir( File.dirname( path ) )
    FileUtils.cp_r path, to
    info(" - #{ to }", '.')
  end
  
  def delete_file(path, force=false)
    if force
      FileUtils.rm_rf( pathto )
    else
      FileUtils.rm_( pathto )
    end
    info(" x #{ path }", '.')
  end

end

end