# frozen_string_literal: true

class Deck
  include Constants

  attr_accessor :cards

  def initialize
    @cards = CARDS
  end

  def deliver_card(participant, counts)
    return if cards.empty?

    cards = add_card!(counts)
    participant.cards << cards
    calculate_score!(participant, cards)
  end

  private

  def add_card!(counts = 1)
    cards.shuffle!.pop(counts)
  end

  def calculate_score!(participant, cards)
    cards.each { |card| participant.score += CARD_POINTS[card] }
  end
end
