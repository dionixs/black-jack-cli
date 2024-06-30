# frozen_string_literal: true

class Participant
  include Constants
  include Validation

  attr_accessor :bank, :cards, :sum
  attr_reader :name

  def initialize
    @bank = INITIAL_BANK
    @cards = []
    @sum = INITIAL_SUM
  end

  def skip_move; end

  def add_card; end
end
