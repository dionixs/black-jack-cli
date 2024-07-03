# frozen_string_literal: true

class Game
  include Constants
  include InputHandler
  include Rules
  include GameBankHandler

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
    @bank = INITIAL_GAME_BANK
    @dealer = Dealer.new
    @player = nil
    @game_end = false
    @display = nil
    @deck = Deck.new(self)
  end

  def start_game
    block_given? ? yield : setup_game
    loop do
      if game_end?
        game_results
        break
      end
      make_moves
    end
  end

  def winner
    Participant.send(:winner)
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

  def game_results
    calculate_bank!
    display.show_game
    new_game
  end

  def new_game
    input = rematch_input
    start_game { reset_game! } if input.downcase == 'y'
  rescue StandardError => e
    puts e.message
    retry
  end

  def reset_game!
    display.new_game
    self.game_end = false
    players_reset!
    deck.reset_deck!
    setup_game
  end

  def players_reset!
    players.each(&:reset!)
    return unless bank_zero?

    players.each(&:reset_bank!)
    display.show_reset_bank
  end

  def players
    Participant.all
  end
end
