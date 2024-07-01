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

  def make_move(input, deck)
    raise KeyError, INPUT_ERROR unless input >= 1 && input <= 3

    actions(deck).fetch(input).call
  end

  protected

  def skip_move
    puts 'Передача хода противнику...'
    sleep 0.5
  end

  def show_cards(game); end

  private

  def actions(deck)
    {
      1 => -> { skip_move },
      2 => -> { add_card(deck) },
      3 => -> { show_cards(game) }
    }
  end
end
