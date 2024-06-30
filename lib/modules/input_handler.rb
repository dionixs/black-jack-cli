# frozen_string_literal: true

module InputHandler
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def user_input(message)
      print "#{message}: "
      gets&.strip
    end
  end
end
