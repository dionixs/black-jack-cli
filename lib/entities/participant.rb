# frozen_string_literal: true

class Participant
  include Constants
  include Validation

  attr_accessor :bank, :cards, :score
  attr_reader :name

  def initialize
    @bank = INITIAL_BANK
    @cards = []
    @score = INITIAL_SUM
  end

  def make_move(game); end

  def three_cards?
    cards.size == 3
  end

  protected

  def skip_move; end

  private

  def add_card(deck)
    return if cards.size >= 3

    puts "#{name} берет новую карту...."
    sleep(1)
    deck.deliver_card(self)
  end
end
