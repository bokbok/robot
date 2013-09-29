class RobotScenarioContext
  TMP_DIR = File.dirname(__FILE__) + '/tmp'

  def initialize
    @robot_out = StringIO.new
    @instructor = Assembly.assemble(@robot_out)
  end

  def self.current
    @current ||= new
  end

  def self.reset
    @current.cleanup if @current
    @current = nil
  end

  def run_commands_in_file(commands)
    command_file = TMP_DIR + "/commands.robot"
    File.open(command_file, 'w') do |file|
      commands.each { |commands| file.puts(commands) }
    end

    File.open(command_file, 'r') do |file|
      @instructor.issue_commands_from(file)
    end
  end

  def check_output(output)
    @robot_out.string.split("\n").last.strip.should =~ /#{output}/
  end

  def cleanup
    FileUtils.rm_rf(TMP_DIR)
    FileUtils.mkdir_p(TMP_DIR)
  end

end

Before("@robot") do
  RobotScenarioContext.reset
end

After("@robot") do
  RobotScenarioContext.reset
end

Given /^The robot executes the following commands in a file:$/ do |table|
  RobotScenarioContext.current.run_commands_in_file(table.hashes.map{ |row| row["command"] })
end

Then /^the robot should have reported its end location and orientation are "([^"]*)"$/ do |output|
  RobotScenarioContext.current.check_output(output)
end