# frozen_string_literal: true

module GameBankHandler
  def make_auto_bet
    puts 'Автоматическая ставка $10 в банк игры...'
    make_auto_bet!
    sleep 1
  end

  def calculate_bank!
    return calculate_bank_for_draw if draw?

    if winner.is_a? Player
      player.win(bank)
    elsif winner.is_a? Dealer
      dealer.win(bank)
    end
    self.bank = 0
  end

  def calculate_bank_for_draw
    players.each { |player| player.bank += (bank / 2) }
    self.bank = 0
  end

  def make_auto_bet!
    players.each do |player|
      player.bank -= 10
      self.bank += 10
    end
  end
end
