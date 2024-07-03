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
      self.class.user_input(message).to_i
    end

    private

    def rematch_input
      message = 'Вы хотите сыграть еще раз? (Y/n)'
      input = self.class.user_input(message).downcase
      raise 'Введите корректное значение!' if input != 'y' && input != 'n'

      input
    end

    def message(player)
      player.three_cards? ? MAKE_MOVE_WITHOUT_ADD_CARD : MAKE_MOVE
    end
  end
end
