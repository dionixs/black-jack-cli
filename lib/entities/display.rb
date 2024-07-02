# frozen_string_literal: true

class Display
  attr_reader :game, :player, :dealer

  def self.welcome(name)
    puts "Добро пожаловать в игру #{name}!"
  end

  def initialize(game)
    @game = game
    @player = game.player
    @dealer = game.dealer
  end

  def show_game
    dealer_info
    player_info
    display_winner
  end

  private

  def display_winner
    return puts 'Ничья' if game.draw?

    puts "Победитель игры: #{game.winner.name}"
  end

  def dealer_info
    puts "Карты игрока #{dealer.name}: #{dealer_cards}"
    puts dealer_score if game.game_end?
    puts "Банк игрока #{dealer.name}: #{dealer.bank}"
  end

  def player_info
    puts "Ваши карты: #{player_cards}"
    puts "Ваша сумма очков: #{player.score}"
    puts "Ваш банк: #{player.bank}"
  end

  def dealer_cards
    if game.game_end?
      dealer.cards.join(', ')
    else
      dealer.cards.map { '*' }.join(' ')
    end
  end

  def dealer_score
    "Сумма очков игрока #{dealer.name}: #{dealer.score}"
  end

  def player_cards
    player.cards.join(' ')
  end
end
