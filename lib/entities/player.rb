# frozen_string_literal: true

class Player < Participant
  include InputHandler

  attr_writer :name

  validate :name, presence: true, length: { min: 2, max: 50 }

  def self.welcome(name)
    puts "Добро пожаловать в игру #{name}!"
  end

  def initialize
    yield self if block_given?
    super
    validate!
    self.class.welcome(name)
  end

  def make_move(game, input)
    return if game.game_end?

    raise KeyError, INPUT_ERROR unless valid_input?(input)

    actions(game).fetch(input).call
    game.display.show_game unless game.game_end?
  end

  protected

  def skip_move
    puts 'Передача хода противнику...'
    sleep 1
  end

  def show_cards(game)
    game.game_end = true
    game.deck.calculate_score!(self)
  end

  private

  def actions(game)
    {
      1 => -> { skip_move },
      2 => -> { show_cards(game) },
      3 => -> { add_card(game.deck) }
    }
  end
end
