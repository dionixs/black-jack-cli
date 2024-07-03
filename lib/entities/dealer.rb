# frozen_string_literal: true

class Dealer < Participant
  def initialize
    @name = self.class.name
    super
  end

  def make_move(game)
    return if game.game_end?

    puts 'Ход противника...'
    sleep(1)

    return skip_move if score >= 17

    add_card(game.deck)
  end

  protected

  def skip_move
    puts 'Противник передает вам ход...'
  end
end
