class Position
  attr_reader :x
  attr_reader :y

  def initialize(x, y, table)
    @x = x
    @y = y

    @table = table
  end

  def advance(orientation)
    @table.position(*orientation.advance(x, y))
  end

  def to_s
    "#{x},#{y}"
  end
end