# frozen_string_literal: true

class Display
  attr_reader :player, :dealer

  def self.welcome(name)
    puts "Добро пожаловать в игру #{name}!"
  end

  def initialize(game)
    @player = game.player
    @dealer = game.dealer
  end

  def show_game
    puts "Карты игрока #{dealer.name}: #{dealer_cards}"
    # puts "\tСумма очков игрока #{dealer.name}: #{dealer.score}"
    puts "Банк игрока #{dealer.name}: #{dealer.bank}"

    puts "Ваши карты: #{player.cards.join(' ')}"
    puts "Ваша сумма очков: #{player.score}"
    puts "Ваш банк: #{player.bank}"
    # puts yield if block_given?
  end

  # def display_winner
  #
  # end

  # def who_win?(player)
  # end

  private

  def dealer_cards
    dealer.cards.map! { '*' }.join(' ')

    # dealer.cards.join(', ')
  end
end
