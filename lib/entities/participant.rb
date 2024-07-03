# frozen_string_literal: true

class Participant
  include Constants
  include Validation

  attr_accessor :bank, :cards, :score
  attr_reader :name

  class << self
    def all
      ObjectSpace.each_object(self).to_a
    end

    private

    def winner
      participants = all
      player = participants.find { |p| p.is_a?(Player) }
      dealer = participants.find { |p| p.is_a?(Dealer) }

      return dealer if player.lose?

      return player if dealer.lose?

      player.score > dealer.score ? player : dealer
    end
  end

  def initialize
    @bank = INITIAL_BANK_PARTICIPANT
    @cards = []
    @score = INITIAL_SCORE
  end

  def make_move(game); end

  def lose?
    score > 21
  end

  def win(bank)
    self.bank += bank
  end

  def three_cards?
    cards.size == 3
  end

  def reset!
    @cards = []
    @score = INITIAL_SCORE
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
