# frozen_string_literal: true

class Game
  include Constants
  include InputHandler

  attr_accessor :player, :bank, :display, :game_end
  attr_reader :dealer, :deck

  def self.initialize_game
    game = new
    game.player = Player.new { |p| p.name = user_input('Введите ваше имя') }
    game.display = Display.new(game)
    game
  rescue StandardError => e
    puts e.message
    retry
  end

  def initialize
    @bank = INITIAL_BANK
    @dealer = Dealer.new
    @player = nil
    @game_end = false
    @display = nil
    @deck = Deck.new(self)
  end

  def start_game
    setup_game
    loop do
      display.show_game
      break if game_end?

      make_moves
    end
  end

  def game_end?
    return true if three_cards? || game_end

    false
  end

  def three_cards?
    player.three_cards? && dealer.three_cards?
  end

  def winner
    if player.score > 21
      self.game_end = true
      dealer
    elsif dealer.score > 21
      self.game_end = true
      player
    elsif player.score > dealer.score
      self.game_end = true
      player
    elsif dealer.score > player.score
      self.game_end = true
      dealer
    else
      self.game_end = true
    end
  end

  def draw?
    dealer.score == player.score
  end

  private

  def setup_game
    deal_cards(2)
    make_auto_bet
  end

  def make_moves
    player.make_move(self, make_move_input(player))
    dealer.make_move(self)
  rescue StandardError => e
    puts e.message
    retry
  end

  def deal_cards(counts = 1)
    puts 'Раздача карт...'
    players.each { |player| deck.deliver_card(player, counts) }
    sleep 1
  end

  def make_auto_bet
    puts 'Автоматическая ставка в банк игры...'
    players.each do |player|
      player.bank -= 10
      self.bank += 10
    end
    sleep 1
  end

  def players
    [dealer, player]
  end
end
