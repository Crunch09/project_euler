require_relative 'spec_helper'

describe Card do
  it 'consists of a value and type' do
    expect(subject).to respond_to :value
    expect(subject).to respond_to :type
  end

  it 'returns its value and type as string' do
    subject.value = "5"
    subject.type = "C"
    expect(subject.to_s).to eq "5C"
  end

  it 'gets the index of a card' do
    subject.value = "5"
    expect(subject.index).to eq 3
    subject.value = "J"
    expect(subject.index).to eq 9
    subject.value = "A"
    expect(subject.index).to eq 12
    subject.value = "2"
    expect(subject.index).to eq 0
    subject.value = "9"
    expect(subject.index).to eq 7
  end

  it 'gets the next index of a card' do
    subject.value = "3"
    n = subject.next
    expect(n).to eq 2
    subject.value = "K"
    n = subject.next
    expect(n).to eq 12
    subject.value = "A"
    n = subject.next
    expect(n).to eq 0
  end

end
