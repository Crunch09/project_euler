require_relative 'spec_helper'
describe Hand do
  it 'consists of cards' do
    expect(subject).to respond_to :cards
  end

  it 'gets the values of all cards' do
    subject.cards << Card.new("2", "C")
    subject.cards << Card.new("T", "H")
    subject.cards << Card.new("T", "C")
    subject.cards << Card.new("7", "S")
    subject.cards << Card.new("A", "D")
    expect(subject.values).to eq ["2", "T", "T", "7", "A"]
  end

  it 'gets the type of all cards' do
    subject.cards << Card.new("2", "C")
    subject.cards << Card.new("T", "H")
    subject.cards << Card.new("T", "C")
    subject.cards << Card.new("7", "S")
    subject.cards << Card.new("A", "D")
    expect(subject.types).to eq ["C", "H", "C", "S", "D"]
  end

  it 'gets the indexes of all cards' do
    subject.cards << Card.new("2", "C")
    subject.cards << Card.new("T", "H")
    subject.cards << Card.new("T", "C")
    subject.cards << Card.new("7", "S")
    subject.cards << Card.new("A", "D")
    expect(subject.indexes).to eq [0, 8, 8, 5, 12]
  end

  it 'detects a royal flush' do
    subject.stub(:values).and_return(['A', 'K', 'Q', 'T', 'J'])
    subject.stub(:types).and_return(['C', 'C', 'C', 'C', 'C'])
    expect(subject.royal_flush?).to be_true
  end

  it 'detects when its not a royal flush' do
    subject.stub(:values).and_return(['A', 'K', '7', 'T', 'J'])
    subject.stub(:types).and_return(['C', 'C', 'H', 'C', 'C'])
    expect(subject.royal_flush?).to be_false
  end

  it 'detects a straight flush' do
    subject.cards << Card.new("6", "C")
    subject.cards << Card.new("7", "C")
    subject.cards << Card.new("8", "C")
    subject.cards << Card.new("5", "C")
    subject.cards << Card.new("9", "C")
    expect(subject.straight_flush?).to be_true
  end

  it 'detects a straight flush' do
    subject.cards << Card.new("6", "C")
    subject.cards << Card.new("3", "H")
    subject.cards << Card.new("8", "C")
    subject.cards << Card.new("5", "S")
    subject.cards << Card.new("9", "D")
    expect(subject.straight_flush?).to be_false
  end

  it 'detects a overlapping straight' do
    subject.cards << Card.new("A", "C")
    subject.cards << Card.new("2", "H")
    subject.cards << Card.new("3", "C")
    subject.cards << Card.new("K", "S")
    subject.cards << Card.new("Q", "D")
    expect(subject.straight?).to be_true
  end

  it 'detects a four of a kind' do
    subject.stub(:values).and_return(['8', '8', '7', '8', '8'])
    expect(subject.four_of_a_kind?).to be_true
  end

  it 'detects when its not four of a kind' do
    subject.stub(:values).and_return(['4','3','3', 'J'])
    expect(subject.four_of_a_kind?).to be_false
  end

  it 'detects a full house' do
    subject.stub(:values).and_return(%w(3 K 3 3 K))
    expect(subject.full_house?).to be_true
  end

  it 'detects when its not a full house' do
    subject.stub(:values).and_return(%w(A T 8 K 8))
    expect(subject.full_house?).to be_false
  end

  it 'detects a flush' do
    subject.stub(:types).and_return(%w(D D D D D))
    expect(subject.flush?).to be_true
  end

  it 'detects a flush' do
    subject.stub(:types).and_return(%w(D H D D D))
    expect(subject.flush?).to be_false
  end

  it 'detects three of a kind' do
    subject.stub(:values).and_return(%w(A 8 8 K 8))
    expect(subject.three_of_a_kind?).to be_true
  end

  it 'detects when there are not three of a kind' do
    subject.stub(:values).and_return(%w(A J 8 K 8))
    expect(subject.three_of_a_kind?).to be_false
  end

  it 'detects when there are two pairs' do
    subject.stub(:values).and_return(%w(A J J 7 A 4))
    expect(subject.two_pair?).to be_true
  end

  it 'detects when there are not two pairs' do
    subject.stub(:values).and_return(%w(A J 5 7 A 4))
    expect(subject.two_pair?).to be_false
  end

  it 'detects one pair' do
    subject.stub(:values).and_return(%w(A J 5 7 A 4))
    expect(subject.one_pair?).to be_true
  end

  it 'detects when there is not a single pair' do
    subject.stub(:values).and_return(%w(8 T 6 Q 5))
    expect(subject.one_pair?).to be_false
  end

  it 'detects the highest card in the hand' do
    subject.stub(:indexes).and_return([1, 3, 4, 10, 9])
    expect(subject.highest_card).to eq 10
  end

  it 'gets the winner of a hand' do
    subject.cards << Card.new("A", "C")
    subject.cards << Card.new("A", "H")
    subject.cards << Card.new("3", "C")
    subject.cards << Card.new("K", "S")
    subject.cards << Card.new("Q", "D")
    hand_two = Hand.new
    hand_two.cards << Card.new("T", "C")
    hand_two.cards << Card.new("2", "H")
    hand_two.cards << Card.new("8", "C")
    hand_two.cards << Card.new("Q", "S")
    hand_two.cards << Card.new("K", "D")
    expect(subject.beats?(hand_two)).to be true

    subject = Hand.new
    subject.cards << Card.new("A", "C")
    subject.cards << Card.new("A", "H")
    subject.cards << Card.new("3", "C")
    subject.cards << Card.new("K", "S")
    subject.cards << Card.new("Q", "D")
    hand_two = Hand.new
    hand_two.cards << Card.new("T", "C")
    hand_two.cards << Card.new("2", "C")
    hand_two.cards << Card.new("8", "C")
    hand_two.cards << Card.new("Q", "C")
    hand_two.cards << Card.new("K", "C")
    expect(subject.beats?(hand_two)).to be false
  end

  it 'checks the higher value of the same rank' do
    subject.cards << Card.new("A", "C")
    subject.cards << Card.new("5", "H")
    subject.cards << Card.new("3", "C")
    subject.cards << Card.new("K", "S")
    subject.cards << Card.new("Q", "D")
    hand_two = Hand.new
    hand_two.cards << Card.new("T", "C")
    hand_two.cards << Card.new("2", "H")
    hand_two.cards << Card.new("8", "C")
    hand_two.cards << Card.new("Q", "S")
    hand_two.cards << Card.new("K", "C")
    expect(subject.beats?(hand_two)).to be true

    subject = Hand.new
    subject.cards << Card.new("7", "C")
    subject.cards << Card.new("5", "H")
    subject.cards << Card.new("3", "C")
    subject.cards << Card.new("K", "S")
    subject.cards << Card.new("Q", "D")
    hand_two = Hand.new
    hand_two.cards << Card.new("T", "C")
    hand_two.cards << Card.new("2", "H")
    hand_two.cards << Card.new("8", "C")
    hand_two.cards << Card.new("Q", "S")
    hand_two.cards << Card.new("K", "C")
    expect(subject.beats?(hand_two)).to be false

    subject = Hand.new
    subject.cards << Card.new("7", "C")
    subject.cards << Card.new("Q", "H")
    subject.cards << Card.new("3", "C")
    subject.cards << Card.new("K", "S")
    subject.cards << Card.new("Q", "D")
    hand_two = Hand.new
    hand_two.cards << Card.new("T", "C")
    hand_two.cards << Card.new("2", "H")
    hand_two.cards << Card.new("8", "C")
    hand_two.cards << Card.new("T", "S")
    hand_two.cards << Card.new("K", "C")
    expect(subject.beats?(hand_two)).to be true

    subject = Hand.new
    subject.cards << Card.new("7", "C")
    subject.cards << Card.new("Q", "H")
    subject.cards << Card.new("3", "C")
    subject.cards << Card.new("Q", "S")
    subject.cards << Card.new("Q", "D")
    hand_two = Hand.new
    hand_two.cards << Card.new("T", "C")
    hand_two.cards << Card.new("2", "H")
    hand_two.cards << Card.new("T", "C")
    hand_two.cards << Card.new("T", "S")
    hand_two.cards << Card.new("K", "C")
    expect(subject.beats?(hand_two)).to be true
  end

end
