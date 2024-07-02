# frozen_string_literal: true

class Game
  include Constants
  include InputHandler

  attr_accessor :player, :bank, :display, :game_end
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
    @game_end = false
  end

  def start_game
    deal_cards(2)
    make_auto_bet

    loop do
      show_game
      break if game_end?

      begin
        player.make_move(self.class.user_input(MAKE_MOVE).to_i, self)
        if game_end?
          show_game
          break
        end
        dealer.make_move(self)
      rescue StandardError => e
        puts e.message
        retry
      end
    end
  end

  def game_end?
    return true if (player.cards.size == 3 && dealer.cards.size == 3) || game_end

    false
  end

  def winner
    if player.score > 21
      dealer if dealer.score <= 21
    elsif dealer.score > 21
      player if player.score <= 21
    else
      return player if player.score > dealer.score

      dealer if dealer.score > player.score
    end
  end

  def draw?
    dealer.score == player.score
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
