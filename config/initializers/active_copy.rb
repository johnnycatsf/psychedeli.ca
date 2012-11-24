require 'active_copy'
require 'rubypython'

# Add the Markdown template handler.
ActionView::Template.register_template_handler :md, ActiveCopy::Template

# Extra coaxing for Heroku to accept RubyPython and Pygments.rb
RubyPython.start python_exe: "python" if Rails.env.stage?
