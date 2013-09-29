class Table
  def initialize(width, height)
    @width = width
    @height = height
  end

  def position(x, y)
    x = x.to_i
    y = y.to_i

    check_range!(x, y)
    Position.new(x, y, self)
  end

  private
  def check_range!(x, y)
    unless x >= 0 && x < @width && y >= 0 && y < @height
      raise "Position #{x}, #{y} is off the table"
    end
  end
end