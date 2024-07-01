# frozen_string_literal: true

class Game
  include Constants
  include InputHandler

  attr_accessor :player, :bank, :display
  attr_reader :dealer, :deck

  def self.initialize_game
    game = new
    game.player = Player.new { |p| p.name = user_input('Введите ваше имя') }
    Display.welcome(game.player.name)
    game
  rescue StandardError => e
    puts e.message
    retry
  end

  def initialize
    @bank = INITIAL_BANK
    @deck = Deck.new
    @dealer = Dealer.new
    @player = nil
    @display = nil
  end

  def start_game
    deal_cards(2)
    make_auto_bet

    loop do
      show_game
      break if player.cards.size == 3 && dealer.cards.size == 3

      begin
        input = self.class.user_input(MAKE_MOVE).to_i
        player.make_move(input, deck)
        dealer.make_move(deck)
      rescue StandardError => e
        puts e.message
        retry
      end
    end
  end

  private

  def show_game
    self.display = Display.new(self)
    display&.show_game
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
