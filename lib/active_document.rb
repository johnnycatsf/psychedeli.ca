require 'bundler'
Bundler.require :active_document

# ActiveDocument reads Markdown files in +app/documents+ instead of a
# database for your Rails models. Inspired by Jekyll, it uses YAML front
# matter to set up metadata for each page, then renders it using
# +ActionView+. For production, +Rake+ tasks are provided to precompile
# the Markdown files to pure HTML for performance purposes.
module ActiveDocument
  VERSION = 'alpha1'
end
