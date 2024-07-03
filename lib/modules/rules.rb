# frozen_string_literal: true

module Rules
  def game_end?
    return true if three_cards? || game_end

    false
  end

  def three_cards?
    player.three_cards? && dealer.three_cards?
  end

  def draw?
    dealer.score == player.score
  end
end
