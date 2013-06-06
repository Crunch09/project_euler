class Hand
  attr_accessor :cards

  HIGH_CARD = 1
  ONE_PAIR = 2
  TWO_PAIR = 3
  THREE_OF_A_KIND = 4
  STRAIGHT = 5
  FLUSH = 6
  FULL_HOUSE = 7
  FOUR_OF_A_KIND = 8
  STRAIGHT_FLUSH = 9
  ROYAL_FLUSH = 10

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

  def beats? other_hand
    rank_of_first_hand = self.rank
    rank_of_second_hand = other_hand.rank
    if rank_of_first_hand == rank_of_second_hand
      has_higher_rank_of? rank_of_first_hand, other_hand
    else
      rank_of_first_hand > rank_of_second_hand
    end
  end

  def rank
    if royal_flush?
      ROYAL_FLUSH
    elsif straight_flush?
      STRAIGHT_FLUSH
    elsif four_of_a_kind?
      FOUR_OF_A_KIND
    elsif full_house?
      FULL_HOUSE
    elsif flush?
      FLUSH
    elsif straight?
      STRAIGHT
    elsif three_of_a_kind?
      THREE_OF_A_KIND
    elsif two_pair?
      TWO_PAIR
    elsif one_pair?
      ONE_PAIR
    else
      HIGH_CARD
    end
  end

  private

  def has_higher_rank_of? rank, other_hand
    hand_one_ixs = self.indexes.sort.reverse
    hand_two_ixs = other_hand.indexes.sort.reverse
    case rank
    when HIGH_CARD
      return higher_card? other_hand
    when ONE_PAIR
      pair_one = hand_one_ixs.select{|e| hand_one_ixs.count(e) > 1}.uniq.first
      pair_two = hand_two_ixs.select{|e| hand_two_ixs.count(e) > 1}.uniq.first
      if pair_one == pair_two
        return higher_card? other_hand
      else
        return pair_one > pair_two
      end
    when TWO_PAIR
      return higher_card? other_hand
    when THREE_OF_A_KIND, FULL_HOUSE
      ix_of_three_one = hand_one_ixs.select{|e| hand_one_ixs.count(e) == 3}.uniq.first
      ix_of_three_two = hand_two_ixs.select{|e| hand_two_ixs.count(e) == 3}.uniq.first
      if ix_of_three_one == ix_of_three_two
        return higher_card? other_hand
      else
        return ix_of_three_one > ix_of_three_two
      end
    when FOUR_OF_A_KIND
      ix_of_four_one = hand_one_ixs.select{|e| hand_one_ixs.count(e) == 3}.uniq.first
      ix_of_four_two = hand_two_ixs.select{|e| hand_two_ixs.count(e) == 3}.uniq.first
      if ix_of_four_one == ix_of_four_two
        return higher_card? other_hand
      else
        return ix_of_four_one > ix_of_four_two
      end
    else
      higher_card? other_hand
    end

  end

  def higher_card? other_hand
    hand_one_ixs = self.indexes.sort.reverse
    hand_two_ixs = other_hand.indexes.sort.reverse
    hand_one_ixs.each_with_index do |val, ix|
      if val > hand_two_ixs[ix]
        return true
      elsif val < hand_two_ixs[ix]
        return false
      end
    end
    false
  end

end
