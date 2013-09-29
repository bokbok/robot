class Robot
  attr_reader :position
  attr_reader :orientation

  COMPASS = %w{north east south west}.freeze

  def initialize(table)
    @table = table
  end

  def place(x, y, orientation)
    orientation = orientation.to_s.downcase
    raise "Orientation #{orientation} is not valid" unless COMPASS.include?(orientation)
    @orientation = orientation
    @position = @table.position(x, y)
  end

  def move
    check_in_position!
    @position = position.advance(orientation)
  end

  def left
    rotate(-1)
  end

  def right
    rotate(1)
  end

  def report
    return "Currently at #{position.x},#{position.y} Facing #{orientation.upcase}" if in_position?
    ""
  end

  private
  def rotate(dir)
    check_in_position!
    index = COMPASS.index(@orientation)
    @orientation = COMPASS[(index + dir) % COMPASS.length]
  end

  def check_in_position!
    raise "Robot is not currently on the table" unless in_position?
  end

  def in_position?
    position && orientation
  end
end