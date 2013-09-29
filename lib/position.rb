class Position
  attr_reader :x
  attr_reader :y

  ADVANCES = { north: [0, 1].freeze,
               south: [0, -1].freeze,
               east: [1, 0].freeze,
               west: [-1, 0].freeze }.freeze

  def initialize(x, y, table)
    @x = x
    @y = y

    @table = table
  end

  def advance(direction)
    advance = ADVANCES[direction.to_sym]

    @table.position(x + advance[0], y + advance[1])
  end

  def to_s
    "#{x},#{y}"
  end
end