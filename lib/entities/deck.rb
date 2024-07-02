# frozen_string_literal: true

class Deck
  include Constants

  attr_accessor :cards

  def initialize
    @cards = CARDS
  end

  def deliver_card(participant, counts = 1)
    return if cards.empty?

    deal_cards!(counts).each do |card|
      participant.cards << card
      calculate_score!(participant, card)
    end
  end

  def calculate_score!(participant, card)
    participant.score += CARD_POINTS[card]
  end

  private

  def deal_cards!(counts = 1)
    cards.shuffle!.pop(counts)
  end
end
