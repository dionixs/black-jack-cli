# frozen_string_literal: true

module Rules
  def game_end?
    return true if three_cards? || game_end ||
                   player.bank_zero? || dealer.bank_zero?

    false
  end

  def three_cards?
    player.three_cards? && dealer.three_cards?
  end

  def bank_zero?
    player.bank_zero? || dealer.bank_zero?
  end

  def draw?
    dealer.score == player.score
  end
end
