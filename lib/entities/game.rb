# frozen_string_literal: true

class Game
  include Constants
  include InputHandler
  include Rules

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
      break if game_end?

      make_moves
    end
  end

  def winner
    return if draw?

    winner = Participant.winner
    if winner.is_a? Player
      player.bank = bank
    else
      dealer.bank = bank
    end
    self.game_end = true
    winner
  end

  private

  def setup_game
    deal_cards(2)
    make_auto_bet
    display.show_game
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
    Participant.all
  end
end
