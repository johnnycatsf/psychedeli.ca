require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/array/wrap'
require 'active_model/mass_assignment_security/permission_set'
require 'active_model/mass_assignment_security/sanitizer'

module ActiveCopy
  # Attribute storage and handling for +ActiveCopy+ models.
  module Attributes
    extend ActiveSupport::Concern

    DEFAULT_PATH = "public/#{self.model_name.pluralize}/#{self.id}.html"
    DEFAULT_ATTRS = [:layout]

    included do
      class_attribute :_accessible_attributes
      class_attribute :_deployment_path
    end

    module ClassMethods
      def attr_accessible(*args)
        args.each do |attribute|
          self._accessible_attributes << attribute
        end
      end

      def deploy_to file_path
        self._deployment_path = file_path
      end

      def accessible_attributes
        if self._accessible_attributes.nil?
          DEFAULT_ATTRS
        else
          self._accessible_attributes.merge DEFAULT_ATTRS
        end
      end

      def deployment_path
        self._deployment_path || DEFAULT_PATH
      end
    end
  end
end
