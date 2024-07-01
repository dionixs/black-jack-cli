# frozen_string_literal: true

class Deck
  include Constants

  attr_accessor :cards

  def initialize
    @cards = CARDS
  end

  def deliver_card(participant, counts)
    participant.cards << add_card!(counts)
  end

  private

  def add_card!(counts = 1)
    cards.shuffle!.pop(counts)
  end
end
