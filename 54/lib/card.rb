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

  def index
    case self.value
    when "2".."9"
      self.value.to_i - 2
    when "T"
      8
    when "J"
      9
    when "Q"
      10
    when "K"
      11
    when "A"
      12
    end
  end

  def next
    (self.index + 1) % 13
  end
end
