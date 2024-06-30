# frozen_string_literal: true

class Player < Participant
  attr_writer :name

  validate :name, presence: true, length: { min: 2, max: 50 }

  def initialize
    yield self if block_given?
    super
    validate!
  end

  def show_cards; end
end
