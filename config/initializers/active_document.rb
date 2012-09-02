require 'active_document'
ActionView::Template.register_template_handler :md, ActiveDocument::TemplateHandler
