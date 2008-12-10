module Cumulus
  
class Renderer
  
  def initialize(default_context={})
    @ctx = default_context
  end

  def template_for(content, state=nil)
    @templates ||= Hash.new {|h,k|
      slugname = k.last.nil? ? "#{ k.first.singularize }.html" : "#{ k.first.singularize }.#{ k.last }.html"
      puts "Looking for #{ slugname }"
      template = Resources.templates(:first, :slug => slugname )
      if template.nil?
        slugname = k.last.nil? ? "_default.html" : "_default.#{ k.last }.html"
        puts "Not found, resorting to #{ slugname }"
        template = Resources.templates(:first, :slug => slugname )
      end
      h[k] = template
    }
    @templates[[content.collection_type, state]]
  end

  def layout_for(template)
    @layouts ||= Hash.new {|h,k| 
      h[k] = Resources.layouts(:first, :slug => "#{ k }.html")
    }
    @layouts[ template.metadata.fetch('layout', 'main') ]
  end

  def render(template, content, context={})
    context = context_for(template, content, context)
#    pp context
    parser_for(template).render(context)
  end
  
  def context_for(template, content, context={})
    context.merge!({
      'template' => template
    })
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
      # Don't think I need to do this...
      #process_includes(context, content)
    end
    process_includes(context, template)
    context
  end
  
  def render_body(content, context={})
    content.metadata[:body] = render(content, '')
    content
  end
  
  def process_includes(ctx, source)
    source.includes.each do |content_path|
      included_content = Resources.collections( :content_path=>content_path )
      unless included_content.empty?
        included_content.each do |cont|
          render_body(cont)
          full_key = cont.content_path.gsub(" ", "_").gsub("-", "_")
          collection, slug = full_key.split("/")
          ctx[collection] ||= {}
          ctx[collection][slug] = cont
          ctx[collection]['_collection'] ||= []
          ctx[collection]['_collection'] << cont
          puts "   > Added ctx [#{collection}][#{slug}]"
        end
      end
    end
  end

  def parser_for(template)
    @parsers ||= Hash.new {|h,k| 
      h[k] = Liquid::Template.parse(k.content) 
    }
    @parsers[template]
  end
    
end
  
end