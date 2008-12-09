# The builder class takes the resources and generates the output
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
    Resources.collections.each do |content|
      # Render content
      output = nil
      source = render(content, '')
      template = template_for( content )
      
      temporarily_replace content, source do
        output = render(template, content)
      end
      
      # Render layout around content
      layout = layout_for(template)
      output = render(layout, output)
      
      # Write to file
      write_file content.output_path, output
      
      # Copy attachments
      content.attachments.each do |attachment|
        copy_file attachment.source_path, attachment.output_path
      end
    end
  end

private

  def template_for(content)
    @templates ||= Hash.new {|h,k| 
      h[k] = Resources.templates(:first, :slug => "#{ k.singularize }.html")
    }
    @templates[content.collection_type]
  end

  def layout_for(template)
    @layouts ||= Hash.new {|h,k| 
      h[k] = Resources.layouts(:first, :slug => "#{ k }.html")
    }
    @layouts[ template.metadata.fetch('layout', 'main') ]
  end
  
  def render(template, content)
    context = context_for(template, content)
#    pp context
    parser_for(template).render(context)
  end
  
  def temporarily_replace(content, value, field=:content)
    old = content.metadata[field]
    content.metadata[field] = value
    yield
    content.metadata[field] = old
  end
  
  
  def context_for(template, content)
    context = {
      'template' => template
    }
    if content.is_a? String
      context.merge!({
        'content' => content,
        'content_keys' => []
      })
    else
      context.merge!({
        content.collection_type.singularize => content,
        'content_keys' => content.to_liquid.keys
      })
      process_includes(context, content)
    end
    process_includes(context, template)
    context
  end
  
  def process_includes(ctx, source)
    source.includes.each do |content_path|
      included_content = Resources.collections( :first, :content_path=>content_path )
      unless included_content.nil?
        puts ":::> Adding to ctx [#{included_content.slug}]"
        ctx[included_content.slug.to_s] = included_content
      end
    end
  end

  def parser_for(template)
    @parsers ||= Hash.new {|h,k| 
      h[k] = Liquid::Template.parse(k.content) 
    }
    @parsers[template]
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