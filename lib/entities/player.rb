# frozen_string_literal: true

class Player < Participant
  include InputHandler

  attr_accessor :first_move
  attr_writer :name

  validate :name, presence: true, length: { min: 2, max: 50 }

  def self.welcome(name)
    puts "Добро пожаловать в игру #{name}!"
  end

  def initialize
    @first_move = true
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

  def first_move?
    @first_move
  end

  def reset!
    super
    @first_move = true
  end

  protected

  def skip_move
    return if skipped_move?

    super
    self.first_move = false
    puts 'Передача хода противнику...'
    sleep 1
  end

  def add_card(deck)
    super
    self.first_move = false
  end

  private

  def show_cards(game)
    return if first_move?

    game.game_end = true
    game.deck.calculate_score!(self)
  end

  def actions(game)
    {
      skip_move: -> { skip_move },
      add_card: -> { add_card(game.deck) },
      show_cards: -> { show_cards(game) }
    }
  end
end
