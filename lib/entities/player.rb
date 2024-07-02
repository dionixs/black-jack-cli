# frozen_string_literal: true

class Player < Participant
  include InputHandler

  attr_writer :name

  validate :name, presence: true, length: { min: 2, max: 50 }

  def initialize
    yield self if block_given?
    super
    validate!
  end

  def make_move(input, game)
    raise KeyError, INPUT_ERROR unless input >= 1 && input <= 3

    actions(game).fetch(input).call
  end

  protected

  def skip_move
    puts 'Передача хода противнику...'
    sleep 0.5
  end

  def show_cards(game)
    game.game_end = true
    cards.each { |card| game.deck.calculate_score!(self, card) }
  end

  private

  def actions(game)
    {
      1 => -> { skip_move },
      2 => -> { add_card(game.deck) },
      3 => -> { show_cards(game) }
    }
  end
end
