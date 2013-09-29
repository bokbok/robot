class RobotInstruction
  def initialize(robot, instruction)
    @robot = robot
    @instruction = instruction
  end

  def issue
    unless @instruction.strip.empty?
      bits = @instruction.gsub(/\s*\,\s*/, ',').split(/\s+/)
      command = bits[0].downcase
      args = (bits[1] || "").split(',')

      begin
        res = @robot.send(command, *args)
      rescue NoMethodError, ArgumentError
        raise "Command '#{@instruction}' is not supported by the robot."
      end
    end
  end
end