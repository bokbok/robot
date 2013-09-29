require 'spec_helper'

describe RobotInstruction do
  let(:robot) { double('robot') }

  describe "#issue" do
    describe "for well formed instructions" do
      describe "non parameterised" do
        let(:instruction) { RobotInstruction.new(robot, "BOO") }
        it "should interpret the instruction and issue it" do
          robot.should_receive(:boo).with().and_return("result")

          instruction.issue.should == "result"
        end

      end

      describe "parameterised" do
        describe "without whitespace in the args" do
          let(:instruction) { RobotInstruction.new(robot, "BOO 1,2,3") }

          it "should interpret the instruction and issue it" do
            robot.should_receive(:boo).with("1", "2", "3").and_return("result")

            instruction.issue.should == "result"
          end
        end

        describe "with whitespace in the args" do
          let(:instruction) { RobotInstruction.new(robot, "BOO 1, 2,  3") }

          it "should interpret the instruction and issue it" do
            robot.should_receive(:boo).with("1", "2", "3").and_return("result")

            instruction.issue.should == "result"
          end
        end
      end
    end

    describe "for unsupported instructions" do
        let(:instruction) { RobotInstruction.new(robot, "BOO") }
        let(:robot) { Object.new }

        it "should interpret the instruction and issue it" do
          -> { instruction.issue }.should raise_error("Command 'BOO' is not supported by the robot.")
        end
    end

    describe "for blank instructions" do
        let(:instruction) { RobotInstruction.new(robot, "   ") }
        let(:robot) { double('robot') }

        it "should ignore instruction" do
          instruction.issue
        end
    end

    describe "for unsupported arguments" do
        let(:instruction) { RobotInstruction.new(robot, "TO_S 1,2,3") }
        let(:robot) { Object.new }

        it "should interpret the instruction and issue it" do
          -> { instruction.issue }.should raise_error("Command 'TO_S 1,2,3' is not supported by the robot.")
        end
    end
  end
end