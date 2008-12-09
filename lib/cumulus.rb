$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'pp'
require 'fileutils'
require 'liquid'
require 'active_support'

module Cumulus
  
  VERSION = '0.0.1'
  
  class << self
    
    attr_accessor_with_default :output_dir, 'output'
    attr_accessor_with_default :verbose,    false
    attr_accessor_with_default :dry_run,    false
    
    def config(&block)
      self.instance_eval &block
    end
    
  end
  
end

require 'cumulus/resources'
require 'cumulus/scanner'
require 'cumulus/builder'
