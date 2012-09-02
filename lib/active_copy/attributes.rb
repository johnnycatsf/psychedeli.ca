require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/array/wrap'
require 'active_model/mass_assignment_security/permission_set'
require 'active_model/mass_assignment_security/sanitizer'

module ActiveCopy
  # Attribute storage and handling for +ActiveCopy+ models.
  module Attributes
    extend ActiveSupport::Concern

    included do
      class_attribute :_accessible_attributes
      class_attribute :_protected_attributes
      class_attribute :_active_authorizer

      class_attribute :_mass_assignment_sanitizer
      self.mass_assignment_sanitizer = :logger
    end

    module ClassMethods
      def attr_protected(*args)
        options = args.extract_options!
        role = options[:as] || :default

        self._protected_attributes = protected_attributes_configs.dup

        Array.wrap(role).each do |name|
          self._protected_attributes[name] = self.protected_attributes(name) + args
        end

        self._active_authorizer = self._protected_attributes
      end

      def attr_accessible(*args)
        options = args.extract_options!
        role = options[:as] || :default

        self._accessible_attributes = accessible_attributes_configs.dup

        Array.wrap(role).each do |name|
          self._accessible_attributes[name] = self.accessible_attributes(name) + args
        end

        self._active_authorizer = self._accessible_attributes
      end

      def protected_attributes(role = :default)
        protected_attributes_configs[role]
      end

      def accessible_attributes(role = :default)
        accessible_attributes_configs[role]
      end

      def active_authorizers
        self._active_authorizer ||= protected_attributes_configs
      end
      alias active_authorizer active_authorizers

      def attributes_protected_by_default
        []
      end

      def mass_assignment_sanitizer=(value)
        self._mass_assignment_sanitizer = if value.is_a?(Symbol)
          const_get(:"#{value.to_s.camelize}Sanitizer").new(self)
        else
          value
        end
      end

  private

      def protected_attributes_configs
        self._protected_attributes ||= begin
          Hash.new { |h,k| h[k] = BlackList.new(attributes_protected_by_default) }
        end
      end

      def accessible_attributes_configs
        self._accessible_attributes ||= begin
          Hash.new { |h,k| h[k] = WhiteList.new }
        end
      end
    end

  protected

    def sanitize_for_mass_assignment(attributes, role = nil)
      _mass_assignment_sanitizer.sanitize(attributes, mass_assignment_authorizer(role))
    end

    def mass_assignment_authorizer(role)
      self.class.active_authorizer[role || :default]
    end
  end
end
