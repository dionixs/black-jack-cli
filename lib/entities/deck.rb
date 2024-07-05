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
    participant.score = participant.cards.reduce(0) { |sum, card| sum + CARD_POINTS[card] }
    correct_score_for_aces!(participant)
  end

  def reset_deck!
    self.cards = CARDS.shuffle
  end

  private

  def deal_cards!(counts = 1)
    cards.shuffle!.pop(counts)
  end

  def ace?(card)
    ACES.include?(card)
  end

  def correct_score_for_aces!(participant)
    participant.cards.count { |card| ace?(card) }.times do
      participant.score -= 10 if participant.score > 21
    end
  end
end
