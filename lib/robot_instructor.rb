class RobotInstructor
  def initialize(robot, output)
    @robot = robot
    @output = output
  end

  def issue_commands_from(io)
    io.each_line do |line|
      instruction = RobotInstruction.new(@robot, line)
      begin
        @output.puts("> #{instruction.issue}")
      rescue => e
        @output.puts("ERROR: #{e.message}")
      end
    end
  end
end