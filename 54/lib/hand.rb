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

  def four_of_a_kind?
    self.values.select{ |e| self.values.count(e) == 4 }.count > 0
  end

  def full_house?
    uniques = self.values.uniq
    uniques.count == 2 &&
    ((values.count(uniques[0]) == 3 && values.count(uniques[1]) == 2) ||
    (values.count(uniques[0]) == 2 && values.count(uniques[0]) == 3))
  end

  def flush?
    self.types.uniq.count == 1
  end

  def three_of_a_kind?
    values[0..2].each do |v|
      return true if values.count(v) == 3
    end
    false
  end

  def two_pair?
    values.combination(2).each.select do |val|
      val[0] == val[1]
    end.count == 2
  end

  def one_pair?
    values.count == values.uniq.count + 1
  end

  def highest_card
    indexes.max
  end

end
