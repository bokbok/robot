class Orientation
  COMPASS = [:north, :east, :south, :west].freeze

  ADVANCES = { north: [0, 1].freeze,
               south: [0, -1].freeze,
               east: [1, 0].freeze,
               west: [-1, 0].freeze }.freeze

  attr_reader :name

  def initialize(name)
    @name = name.to_s.downcase.to_sym
    raise "Invalid orientation '#{@name}'" unless COMPASS.include?(@name)
  end

  def rotate(dir)
    index = COMPASS.index(@name)
    self.class.new(COMPASS[(index + dir) % COMPASS.length])
  end

  def advance(x, y)
    adv = ADVANCES[@name]

    [x + adv[0], y + adv[1]]
  end

  def ==(other)
    return @name == other.name if other.is_a?(Orientation)
    false
  end

  def to_s
    @name.to_s
  end
end