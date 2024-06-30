# frozen_string_literal: true

class Game
  include Constants
  include InputHandler

  attr_accessor :player

  def self.initialize_game
    game = new
    game.player = Player.new { |p| p.name = user_input('Введите ваше имя') }
    game
  rescue StandardError => e
    puts e.message
    retry
  end

  def initialize
    @bank = INITIAL_BANK
    @dealer = Dealer.new
    @player = nil
  end
end
