# frozen_string_literal: true

class Deck
  include Constants

  attr_accessor :cards
  attr_reader :game

  def initialize(game)
    @game = game
    @cards = CARDS.shuffle
  end

  def deliver_card(participant, counts = 1)
    return if cards.empty?

    deal_cards!(counts).each do |card|
      participant.cards << card

      game.display.show_taken_card(card) if participant.is_a?(Player)
    end

    calculate_score!(participant)
  end

  def calculate_score!(participant)
    participant.score = 0
    participant.cards.each do |card|
      participant.score += if ace?(card)
                             ace_point(participant, card)
                           else
                             CARD_POINTS[card]
                           end
    end
  end

  def reset_deck!
    self.cards = CARDS.shuffle
  end

  private

  def deal_cards!(counts = 1)
    cards.shuffle!.pop(counts)
  end

  def ace?(card)
    %w[🂡 🂱 🃁 🃑].include?(card)
  end

  def ace_point(participant, card)
    return 1 if participant.score + CARD_POINTS[card] > 21

    CARD_POINTS[card]
  end
end
