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
    display_end_game if game.game_end?
  end

  def show_taken_card(card)
    puts "Вы взяли карту: #{card}"

    sleep 1
  end

  private

  def display_end_game
    puts "\tУ обоих игроков 3 карты! Игра окончена!" if game.three_cards?

    return puts "\tИтог игры: Ничья" if game.draw?

    display_winner
  end

  def display_winner
    puts "\tПобедитель игры: #{game.winner.name}"
    puts game.winner.is_a?(Dealer) ? "\tВы проиграли :(" : "\tВы победили!"
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
