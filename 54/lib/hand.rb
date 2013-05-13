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

  def indexes
    cards.map(&:index)
  end

  def royal_flush?
    self.values - ["T", "J", "Q", "K", "A"] == [] &&
    self.types.uniq.count == 1
  end

  def straight_flush?
    straight? && self.types.uniq.count == 1
  end

  def straight?
    self.cards.each do |c|
      straight_count = 1
      cur = c
      while straight_count < 5
        n = cur.next
        if self.indexes.include?(n)
          ix = self.indexes.index(n)
          cur = self.cards[ix]
          straight_count += 1
        else
          break
        end
      end
      return true if straight_count == 5
    end
    false
  end

end
