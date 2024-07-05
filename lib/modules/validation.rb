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
        validate_presence(attribute, value) if options[:presence]
        validate_length(attribute, value, options[:length]) if options[:length]
      end
    end

    def valid_input?(input)
      first_move? && %i[skip_move add_card].include?(input) ||
        three_cards? && %i[skip_move show_cards].include?(input) ||
        skipped_move? && %i[show_cards add_card].include?(input)
    end

    private

    def validate_presence(attribute, value)
      return unless value.nil? || value.empty?

      raise "#{attribute.capitalize} can't be blank"
    end

    def validate_length(attribute, value, length_options)
      if length_options[:min] && value.length < length_options[:min]
        raise "#{attribute.capitalize} is too short (minimum is #{length_options[:min]} characters)"
      end

      return unless length_options[:max] && value.length > length_options[:max]

      raise "#{attribute.capitalize} is too long (maximum is #{length_options[:max]} characters)"
    end
  end
end
