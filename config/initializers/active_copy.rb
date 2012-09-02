require 'active_copy'

ActionView::Template.register_template_handler :md, ActiveCopy::TemplateHandler
