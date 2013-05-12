class Card
  attr_accessor :value
  attr_accessor :type

  def initialize value = nil, type = nil
    self.value = value
    self.type = type
  end

  def to_s
    "#{self.value}#{self.type}"
  end
end
