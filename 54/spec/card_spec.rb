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
end
