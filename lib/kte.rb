require "kte/version"
require 'miller'
module KTE
  class Error < StandardError; end
  # Your code goes here...

  def self.templates_folder
    Pathname.new(File.expand_path('../../templates', __FILE__))
  end
end

require 'kte/template'
require 'kte/templateable'
require 'kte/deployment'
require 'kte/app'
