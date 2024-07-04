# frozen_string_literal: true

module InputHandler
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def user_input(message)
      print "#{message}: "
      gets&.strip
    end
  end

  module InstanceMethods
    include Constants

    def make_move_input(player)
      message = message(player)
      self.class.user_input(message).gsub(' ', '_').to_sym
    end

    private

    def rematch_input
      message = 'Вы хотите сыграть еще раз? (Y/n)'
      input = self.class.user_input(message).downcase
      raise INPUT_ERROR if input != 'y' && input != 'n'

      input
    end

    def message(player)
      return MAKE_FIRST_MOVE if player.first_move?

      return MAKE_MOVE_WITHOUT_ADD_CARD if player.three_cards?

      MAKE_MOVE_WITHOUT_SKIP_MOVE if player.skipped_move?
    end
  end
end
