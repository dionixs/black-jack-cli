# frozen_string_literal: true

class Display
  attr_reader :game, :player, :dealer

  def initialize(game)
    @game = game
    @player = game.player
    @dealer = game.dealer
  end

  def show_game
    dealer_info
    player_info
    display_winner if game.game_end?
  end

  private

  def display_winner
    return puts "\tНичья" if game.draw?

    puts "\tПобедитель игры: #{game.winner.name}"
  end

  def dealer_info
    puts "\tКарты игрока #{dealer.name}: #{dealer_cards}"
    puts dealer_score if game.game_end?
    puts "\tБанк игрока #{dealer.name}: #{dealer.bank}"
  end

  def player_info
    puts "\tВаши карты: #{player_cards}"
    puts "\tВаша сумма очков: #{player.score}"
    puts "\tВаш банк: #{player.bank}"
  end

  def dealer_cards
    if game.game_end?
      dealer.cards.join(', ')
    else
      dealer.cards.map { '*' }.join(' ')
    end
  end

  def dealer_score
    "\tСумма очков игрока #{dealer.name}: #{dealer.score}"
  end

  def player_cards
    player.cards.join(' ')
  end
end
