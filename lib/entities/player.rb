# frozen_string_literal: true

class Player < Participant
  attr_writer :name

  def initialize
    yield self if block_given?
    super
  end
end
