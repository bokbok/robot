require 'spec_helper'


describe RobotInstructor do
  let(:robot) { double('robot') }
  let(:output) { StringIO.new }
  let(:instructor) { RobotInstructor.new(robot, output) }

  describe "#issue_commands_from" do
    describe "single commands" do
      let(:io) { StringIO.new("SOME_COMMAND 1,2,3") }

      it 'should read a command and issue it to the robot' do
        robot.should_receive(:some_command).with('1', '2', '3')

        instructor.issue_commands_from(io)
      end

      it 'should store output' do
        robot.should_receive(:some_command).with('1', '2', '3').and_return("Blah!")
        instructor.issue_commands_from(io)

        output.string.strip.should == "> Blah!"
      end
    end

    describe "multiple commands" do
      let(:io) { StringIO.new("SOME_COMMAND 1,2,3\nOTHER_COMMAND\nLAST_COMMAND") }

      it 'should read commands and issue them to the robot' do
        robot.should_receive(:some_command).with('1', '2', '3')
        robot.should_receive(:other_command)
        robot.should_receive(:last_command)

        instructor.issue_commands_from(io)
      end
    end

    describe "erroneous commands" do
      let(:io) { StringIO.new("SOME_COMMAND 1,2,3\nBAD_COMMAND\nLAST_COMMAND") }

      before :each do
        robot.should_receive(:some_command).with('1', '2', '3')
        robot.should_receive(:bad_command).and_raise("An error")
        robot.should_receive(:last_command)
      end

      it 'should continue after error' do
        instructor.issue_commands_from(io)
      end

      it 'should report the error' do
        instructor.issue_commands_from(io)

        output.string.split("\n").should include("ERROR: An error")
      end
    end
  end
end
