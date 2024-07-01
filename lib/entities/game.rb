# frozen_string_literal: true

class Game
  include Constants
  include InputHandler

  attr_accessor :player, :bank
  attr_reader :dealer, :deck

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
    @deck = Deck.new
    @display = Display.new
    @dealer = Dealer.new
    @player = nil
  end

  def start_game
    deal_cards(2)
    make_auto_bet
    self
  end

  private

  def deal_cards(counts = 1)
    players.each { |player| deck.deliver_card(player, counts) }
  end

  def make_auto_bet
    players.each do |player|
      player.bank -= 10
      self.bank += 10
    end
  end

  def players
    [dealer, player]
  end
end
