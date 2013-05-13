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
end
