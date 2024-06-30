# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attribute, options)
      validations[attribute] = options
    end

    def validations
      @validations ||= {}
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |attribute, options|
        value = send(attribute)
        raise "#{attribute.capitalize} can't be blank" if options[:presence] && (value.empty? || value.nil?)
      end
    end
  end
end
