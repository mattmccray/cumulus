require 'loci/hash_db'

module Loci::Resources
  class << self
    
    # Every source file: Content, Attachment, (¿Template?)
    def all
      @all ||= Loci::HashDB.new
    end
    
    # Only content attachments
    def attachments(filter={})
      filter.merge! :content_type=>:attachment
      puts filter.inspect
      all.find(filter)
    end
    
    # Only content objects
    def collections(filter={})
      filter.merge! :content_type=>:content
      all.find(filter)
    end
    
    # Only templates
    def templates(filter={})
      filter.merge! :content_type=>:template
      all.find(filter)
    end

    # Only templates
    def layouts(filter={})
      filter.merge! :content_type=>:layout
      all.find(filter)
    end
    
    def clear
      all.clear
    end
    
  end
end

require 'loci/resources/base_resource'
require 'loci/resources/attachment'
require 'loci/resources/content'
require 'loci/resources/template'
require 'loci/resources/layout'
