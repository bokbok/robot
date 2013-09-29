class Assembly
  def self.assemble(robot_out)
    @table = Table.new(5, 5)
    @robot = Robot.new(@table)
    @instructor = RobotInstructor.new(@robot, robot_out)
  end
end