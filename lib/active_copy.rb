require 'bundler'
Bundler.require :active_copy

require 'active_copy/attributes'
require 'active_copy/base'
require 'active_copy/markdown'
require 'active_copy/renderer'
require 'active_copy/template'
require 'active_copy/utils'

# ActiveCopy reads Markdown files in +app/documents+ instead of a
# database for your Rails models. Inspired by Jekyll, it uses YAML front
# matter to set up metadata for each page, then renders it using
# +ActionView+. For production, +Rake+ tasks are provided to precompile
# the Markdown files to pure HTML for performance purposes.
module ActiveCopy
  VERSION = 'alpha1'

  # Find all models in the Rails app that inherit from ActiveCopy::Base.
  #def self.models
    #Dir["#{Rails.root}/app/documents/*/"].map do |folder| 
      #File.basename(folder).singularize.camelize.constantize
    #end
  #end
end
