require 'spec_helper'

describe Robot do
  subject { robot }
  let(:robot) { Robot.new(table) }
  let(:table) { double('table') }
  let(:position) { double('position', x: 1, y: 2) }

  before :each do
    table.stub(:position).with(anything, anything).and_return(position)
  end

  describe "#place" do
    describe "position" do
      before :each do
        table.should_receive(:position).with(1, 2).and_return(position)
      end

      it "should place itself at the desired position" do
        robot.place(1, 2, 'north')
        robot.position.should == position
      end
    end

    describe "orientation" do
      it "should not accept an invalid orientation" do
        -> { robot.place(1, 2, 'blah') }.should raise_error("Orientation blah is not valid")
      end

      %w{north south east west}.each do |orientation|
        it "should accept #{orientation}" do
          robot.place(1, 2, orientation)
          robot.orientation.should == orientation
        end

        it "should accept #{orientation} as a symbol" do
          robot.place(1, 2, orientation.to_sym)
          robot.orientation.should == orientation
        end

        it "should accept #{orientation.upcase}" do
          robot.place(1, 2, orientation.upcase)
          robot.orientation.should == orientation
        end
      end
    end
  end

  describe "#move" do
    describe "when in position" do
      %w{north south east west}.each do |orientation|
        describe "when facing #{orientation}" do
          let(:new_position) { double('position') }

          before :each do
            robot.place(1, 2, orientation)
            position.stub(:advance).with(orientation).and_return(new_position)
          end

          it "should ask the position for the new position" do
            robot.move
            robot.position.should == new_position
          end
        end
      end
    end

    describe "when NOT in position" do
      it "should raise an error" do
        -> { robot.move }.should raise_error("Robot is not currently on the table")
      end
    end
  end

  describe "#left" do
    describe "when in position" do
      {'north' => 'west', 'west' => 'south', 'south' => 'east', 'east' => 'north'}.each do |original, rotated|
        describe "when facing #{original}" do
          before :each do
            robot.place(1, 2, original)
          end

          it "should orient it self #{rotated}" do
            robot.left

            robot.orientation.should == rotated
          end
        end
      end
    end

    describe "when NOT in position" do
      it "should raise an error" do
        -> { robot.left }.should raise_error("Robot is not currently on the table")
      end
    end
  end

  describe "#right" do
    describe "when in position" do
      {'north' => 'east', 'east' => 'south', 'south' => 'west', 'west' => 'north'}.each do |original, rotated|
        describe "when facing #{original}" do
          before :each do
            robot.place(1, 2, original)
          end

          it "should orient it self #{rotated}" do
            robot.right

            robot.orientation.should == rotated
          end
        end
      end
    end

    describe "when NOT in position" do
      it "should raise an error" do
        -> { robot.right }.should raise_error("Robot is not currently on the table")
      end
    end
  end

  describe "#report" do
    describe "when in position" do
      before :each do
        robot.place(1, 2, 'north')
      end

      it "should give its position and orientation" do
        robot.report.should == "Currently at 1,2 Facing NORTH"
      end
    end

    describe "when NOT in position" do
      it "should give no report" do
        robot.report.should == ""
      end
    end
  end
end