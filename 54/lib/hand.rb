class Hand
  attr_accessor :cards

  def initialize
    self.cards = []
  end

  def values
    cards.map(&:value)
  end

  def types
    cards.map(&:type)
  end
end
