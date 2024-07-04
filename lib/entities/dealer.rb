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

    return skip_move if score >= 17 && !skipped_move?

    add_card(game.deck)
    game.display.show_game unless game.game_end?
  end

  protected

  def skip_move
    super
    puts 'Противник передает вам ход...'
  end
end
