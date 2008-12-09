require 'cumulus/hash_db'

module Cumulus::Resources
  class << self
    
    # Every source file: Content, Attachment, (¿Template?)
    def all
      @all ||= Cumulus::HashDB.new
    end
    
    # Only content attachments
    def attachments(*args)
      filter = args.extract_options!.merge! :content_type=>:attachment
      all.find((args.first || :all), filter)
    end
    
    # Only content objects
    def collections(*args)
      filter = args.extract_options!.merge! :content_type=>:content
      all.find((args.first || :all), filter)
    end
    
    # Only templates
    def templates(*args)
      filter = args.extract_options!.merge! :content_type=>:template
      all.find((args.first || :all), filter)
    end

    # Only templates
    def layouts(*args)
      filter = args.extract_options!.merge! :content_type=>:layout
      all.find((args.first || :all), filter)
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
