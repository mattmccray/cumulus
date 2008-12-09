require 'cumulus/hash_db'

module Cumulus::Resources
  class << self
    
    # Every source file: Content, Attachment, (¿Template?)
    def all
      @all ||= Cumulus::HashDB.new
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

require 'cumulus/resources/base_resource'
require 'cumulus/resources/attachment'
require 'cumulus/resources/content'
require 'cumulus/resources/template'
require 'cumulus/resources/layout'
