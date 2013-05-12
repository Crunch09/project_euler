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
end
