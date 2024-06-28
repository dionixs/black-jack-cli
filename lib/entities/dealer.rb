# frozen_string_literal: true

class Dealer < Participant
  def initialize
    @name = self.class.name
    super
  end
end
